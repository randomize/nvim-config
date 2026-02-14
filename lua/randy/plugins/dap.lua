return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "theHamsta/nvim-dap-virtual-text",
    },
    lazy = true,
    event = "VeryLazy",
    config = function()
      -- Configure debuggers
      local dap = require("dap")

      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg", -- Must be in PATH
        args = { "--interpreter=vscode" },
      }

      local function detect_unity_port()
        local lines = vim.fn.systemlist({ "ss", "-tlp" })
        if vim.v.shell_error ~= 0 then
          return nil
        end
        for _, line in ipairs(lines) do
          if line:find("Unity") then
            local port = line:match(":(%d+)%s") or line:match(":(%d+)$")
            if port then
              local n = tonumber(port)
              if n and n >= 56000 and n <= 56999 then
                return n
              end
            end
          end
        end
        return nil
      end

      local UNITY_DAP_REPO_URL = "https://github.com/walcht/unity-dap.git"

      local function unity_dap_repo()
        return vim.env.UNITY_DAP_REPO
          or vim.env.UNITY_DAP_SRC
          or vim.g.unity_dap_repo
          or vim.fs.joinpath(vim.fn.stdpath("data"), "unity-dap")
      end

      local function unity_dap_from_repo(repo)
        if not repo or repo == "" then
          return nil
        end
        local candidates = {
          vim.fs.joinpath(repo, "bin", "Release", "unity-debug-adapter.exe"),
        }
        for _, path in ipairs(candidates) do
          if vim.fn.filereadable(path) == 1 then
            return path
          end
        end
        local found = vim.fn.globpath(repo, "**/unity-debug-adapter.exe", false, true)
        if found and #found > 0 then
          table.sort(found)
          return found[#found]
        end
        return nil
      end

      local function build_unity_dap(repo)
        if vim.fn.executable("dotnet") ~= 1 then
          vim.notify("unity-dap: dotnet SDK not found; install dotnet to build", vim.log.levels.ERROR)
          return false
        end
        local result = vim
          .system({
            "dotnet",
            "build",
            "--configuration=Release",
            "unity-debug-adapter/unity-debug-adapter.csproj",
          }, { cwd = repo, text = true })
          :wait()
        if result.code ~= 0 then
          local msg = "unity-dap build failed"
          if result.stderr and result.stderr ~= "" then
            msg = msg .. ":\n" .. result.stderr
          end
          vim.notify(msg, vim.log.levels.ERROR)
          return false
        end
        return true
      end

      local function git_has()
        return vim.fn.executable("git") == 1
      end

      local function ensure_unity_dap_repo(repo)
        if vim.fn.isdirectory(repo) == 1 then
          return true
        end
        if not git_has() then
          vim.notify("unity-dap: git not found; cannot install repo", vim.log.levels.ERROR)
          return false
        end
        local result = vim
          .system({ "git", "clone", "--recurse-submodules", UNITY_DAP_REPO_URL, repo }, { text = true })
          :wait()
        if result.code ~= 0 then
          local msg = "unity-dap install failed"
          if result.stderr and result.stderr ~= "" then
            msg = msg .. ":\n" .. result.stderr
          end
          vim.notify(msg, vim.log.levels.ERROR)
          return false
        end
        return true
      end

      local function update_unity_dap(repo)
        if not git_has() then
          vim.notify("unity-dap: git not found; cannot update repo", vim.log.levels.ERROR)
          return false
        end
        local result = vim.system({ "git", "pull", "--ff-only" }, { cwd = repo, text = true }):wait()
        if result.code ~= 0 then
          local msg = "unity-dap update failed"
          if result.stderr and result.stderr ~= "" then
            msg = msg .. ":\n" .. result.stderr
          end
          vim.notify(msg, vim.log.levels.ERROR)
          return false
        end
        local sub = vim
          .system({ "git", "submodule", "update", "--init", "--recursive" }, { cwd = repo, text = true })
          :wait()
        if sub.code ~= 0 then
          local msg = "unity-dap submodule update failed"
          if sub.stderr and sub.stderr ~= "" then
            msg = msg .. ":\n" .. sub.stderr
          end
          vim.notify(msg, vim.log.levels.ERROR)
          return false
        end
        return true
      end

      -- Unity DAP (Mono-only). Build Unity-DAP and set UNITY_DAP_PATH.
      -- See: https://github.com/walcht/unity-dap
      dap.adapters.unity = function(callback, config)
        local address = config.address or vim.fn.input("Unity address [127.0.0.1]: ", "127.0.0.1")
        local port = config.port or detect_unity_port() or tonumber(vim.fn.input("Unity port: "))

        config.address = address
        config.port = port

        local unity_dap = vim.env.UNITY_DAP_PATH or vim.env.UNITY_DAP_EXE
        if not unity_dap or unity_dap == "" then
          local repo = unity_dap_repo()
          unity_dap = unity_dap_from_repo(repo)
          if (not unity_dap or unity_dap == "") and repo then
            if vim.fn.isdirectory(repo) ~= 1 then
              if not ensure_unity_dap_repo(repo) then
                return
              end
            end
            if build_unity_dap(repo) then
              unity_dap = unity_dap_from_repo(repo)
            end
          end
        end
        if not unity_dap or unity_dap == "" then
          vim.notify(
            "unity-dap: set UNITY_DAP_PATH or UNITY_DAP_REPO (or vim.g.unity_dap_repo)",
            vim.log.levels.ERROR
          )
          return
        end
        unity_dap = vim.fn.expand(unity_dap)

        callback({
          type = "executable",
          command = vim.env.UNITY_DAP_MONO or "mono",
          args = { unity_dap, "--log-level=error" },
        })
      end

      if dap.configurations.cs == nil then
        dap.configurations.cs = {}
      end
      table.insert(dap.configurations.cs, {
        name = "Unity Editor/Player [Mono]",
        type = "unity",
        request = "attach",
      })

      vim.api.nvim_create_user_command("UnityDapBuild", function()
        local repo = unity_dap_repo()
        if not repo or repo == "" then
          vim.notify("unity-dap: set UNITY_DAP_REPO (or vim.g.unity_dap_repo)", vim.log.levels.ERROR)
          return
        end
        if vim.fn.isdirectory(repo) ~= 1 then
          vim.notify("unity-dap repo not found: " .. repo, vim.log.levels.ERROR)
          return
        end
        if build_unity_dap(repo) then
          vim.notify("unity-dap build complete", vim.log.levels.INFO)
        end
      end, {})

      vim.api.nvim_create_user_command("UnityDapInstall", function()
        local repo = unity_dap_repo()
        if not repo or repo == "" then
          vim.notify("unity-dap: set UNITY_DAP_REPO (or vim.g.unity_dap_repo)", vim.log.levels.ERROR)
          return
        end
        if ensure_unity_dap_repo(repo) and build_unity_dap(repo) then
          vim.notify("unity-dap install + build complete", vim.log.levels.INFO)
        end
      end, {})

      vim.api.nvim_create_user_command("UnityDapUpdate", function()
        local repo = unity_dap_repo()
        if not repo or repo == "" then
          vim.notify("unity-dap: set UNITY_DAP_REPO (or vim.g.unity_dap_repo)", vim.log.levels.ERROR)
          return
        end
        if ensure_unity_dap_repo(repo) and update_unity_dap(repo) and build_unity_dap(repo) then
          vim.notify("unity-dap update + build complete", vim.log.levels.INFO)
        end
      end, {})

      -- dap.adapters.go = {
      --   type = 'executable';
      --   command = 'node';
      --   args = { os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js' };
      -- }

      -- dap.configurations.cs = {
      --   {
      --     type = "coreclr",
      --     name = "launch - netcoredbg",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input('Path to dll!', vim.fn.getcwd() .. 'bin/Debug/',
      --         'file')
      --     end,
      --   },
      -- }

      --require('dap.ext.vscode').load_launchjs()
      -- require('dap.ext.vscode').load_launchjs(nil, { coreclr = {'cs'} })

      local map = function(key, command, desc)
        local opts = { noremap = true, silent = true, desc = desc }
        vim.keymap.set("n", key, command, opts)
      end

      local continue = function()
        if vim.fn.filereadable(".vscode/launch.json") then
          -- Always try to reload launch.json in case there
          -- were changes since the last time it was loaded
          require("dap.ext.vscode").load_launchjs(nil, { coreclr = { "cs" } })
        end
        require("dap").continue()
        -- vim.cmd('Telescope dap configurations')
      end

      --vim.keymap.set('n', '<F5>', )["<leader>dc"] = { continue, "Start/Continue debug" }

      --map('<F5>', ':lua require("dap").continue()<CR>', 'Start or Continue debugging')
      map("<F5>", continue, "Start or Continue debugging")
      map("<s-F5>", continue, "Terminate debugging")
      map("<F10>", ':lua require("dap").step_over()<CR>', "Step Over")
      map("<F11>", ':lua require("dap").step_into()<CR>', "Step Into")
      map("<F12>", ':lua require("dap").step_out()<CR>', "Step out")
      map("<F9>", ':lua require("dap").toggle_breakpoint()<CR>', "Toggle Breakpoint")
      map(
        "<Leader>dB",
        ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
        "Set Breakpoint Condition"
      )
      map(
        "<Leader>dlp",
        ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
        "Set Log Point"
      )
      map("<Leader>dr", ':lua require("dap").repl.open()<CR>', "Open Debug Repl")
      map("<Leader>dls", ':lua require("dap").run_last()<CR>', "Run Last Session")
      map("<Leader>dT", ':lua require("dap").terminate()<CR>', "Terminate debugging")

      map("<Leader>du", ':lua require("dapui").toggle()<CR>', "Toggle Debug UI")
      map("<Leader>de", ':lua require("dapui").eval()<CR>', "Evaluate Expression")
      map("<Leader>dR", ':lua require("dapui").open({ reset = true })<CR>', "Reset Debug UI")
      map("<Leader>dts", ':lua require("dapui").toggle("sidebar")<CR>', "Toggle Debug Sidebar")
      map("<Leader>dtt", ':lua require("dapui").toggle("tray")<CR>', "Toggle Debug Tray")

      -- Open/Close dapui windows automatically when starting/stopping debugging

      local dapui = require("dapui")
      local dapuiConfig = {
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.25,
              },
              {
                id = "breakpoints",
                size = 0.25,
              },
              {
                id = "stacks",
                size = 0.25,
              },
              {
                id = "watches",
                size = 0.25,
              },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              {
                id = "repl",
                size = 1.0,
              },
              {
                id = "console",
                size = 0.0,
              },
            },
            position = "bottom",
            size = 7,
          },
        },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      }

      dapui.setup(dapuiConfig)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- Debug adapter for golang
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("dap")
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    event = "VeryLazy",
    opts = {
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = false, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
      --- A callback that determines how a variable is displayed or whether it should be omitted
      --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
      --- @param buf number
      --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
      --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
      --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
      --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value
        else
          return variable.name .. " = " .. variable.value
        end
      end,
      -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

      -- experimental features:
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    },
  },
}
