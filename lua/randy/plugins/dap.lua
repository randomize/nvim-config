return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
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
                command = "netcoredbg", -- Must be in PATH
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

            require("dap.ext.vscode").load_launchjs()

            local map = function(key, command, desc)
                local opts = { noremap = true, silent = true, desc = desc }
                vim.keymap.set("n", key, command, opts)
            end

            map("<F5>", ':lua require("dap").continue()<CR>', "Start or Continue debugging")
            map("<F10>", ':lua require("dap").step_over()<CR>', "Step Over")
            map("<F11>", ':lua require("dap").step_into()<CR>', "Step Into")
            map("<F12>", ':lua require("dap").step_out()<CR>', "Step out")
            map("<F9>", ':lua require("dap").toggle_breakpoint()<CR>', "Toggle Breakpoint")
            map(
                "<Leader>gB",
                ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
                "Set Breakpoint Condition"
            )
            --map('<Leader>glp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', 'Set Log Point')
            map("<Leader>gr", ':lua require("dap").repl.open()<CR>', "Open Debug Repl")
            map("<Leader>gl", ':lua require("dap").run_last()<CR>', "Run Last Session")

            map("<Leader>gui", ':lua require("dapui").toggle()<CR>', "Toggle Debug UI")

            -- Open/Close dapui windows automatically when starting/stopping debugging

            local dapui = require("dapui")
            dapui.setup({
                controls = {
                    element = "repl",
                    enabled = false,
                },
            })

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

    -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, config = function()
    --   require('dapui').setup({})
    -- end
    -- },

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
}
