return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
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
      map("<Leader>dr", ':lua require("dapui").open({ reset = true })<CR>', "Reset Debug UI")
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
