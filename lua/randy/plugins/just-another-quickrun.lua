return {
    {
        "is0n/jaq-nvim",
        cmd = "Jaq",
        config = function(_, opts)
            require("jaq-nvim").setup(opts)
        end,
        keys = {
            { "<space>R", "<cmd>Jaq<CR>", desc = "Run with Jaq" },
        },
        opts = {

            -- Uses vim commands
            internal = {
                lua = "luafile %",
                vim = "source %",
            },

            -- Uses shell commands
            external = {
                markdown = "glow %",
                python = "python %",
                go = "go run %",
                sh = "bash %",
                bashsh = "sh %",
            },
        },

        behavior = {
            -- Default type
            default = "float",

            -- Start in insert mode
            startinsert = false,

            -- Use `wincmd p` on startup
            wincmd = false,

            -- Auto-save files
            autosave = false,
        },

        ui = {
            float = {
                -- See ':h nvim_open_win'
                border = "none",

                -- See ':h winhl'
                winhl = "Normal",
                borderhl = "FloatBorder",

                -- See ':h winblend'
                winblend = 0,

                -- Num from `0-1` for measurements
                height = 0.8,
                width = 0.8,
                x = 0.5,
                y = 0.5,
            },

            terminal = {
                -- Window position
                position = "bot",

                -- Window size
                size = 10,

                -- Disable line numbers
                line_no = false,
            },

            quickfix = {
                -- Window position
                position = "bot",

                -- Window size
                size = 10,
            },
        },
    },
}
