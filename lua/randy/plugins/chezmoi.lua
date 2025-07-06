return {
    {
        'xvzc/chezmoi.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        },
        config = function()
            local chezmoi = require("chezmoi")

            chezmoi.setup {
                edit = {
                    watch = true,
                    force = false,
                },
                events = {
                    on_open = {
                        notification = {
                            enable = true,
                            msg = "Opened a chezmoi-managed file",
                            opts = {},
                        },
                    },
                    on_watch = {
                        notification = {
                            enable = true,
                            msg = "This file will be automatically applied",
                            opts = {},
                        },
                    },
                    on_apply = {
                        notification = {
                            enable = true,
                            msg = "Successfully applied",
                            opts = {},
                        },
                    },
                },
                telescope = {
                    select = { "<CR>" },
                },
            }

            -- register the Telescope extension (safe-call avoids errors if Telescope
            -- hasn’t been loaded yet during a first lazy-load)
            pcall(require("telescope").load_extension, "chezmoi")
        end
    }
}
