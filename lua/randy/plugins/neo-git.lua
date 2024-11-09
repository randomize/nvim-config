return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
            "echasnovski/mini.pick",         -- optional
        },
        lazy = false,
        config = function()
            local neogit = require('neogit')

            vim.keymap.set("n", "<leader>gs", neogit.open,
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>",
                { silent = true, noremap = true }
            )

            vim.keymap.set("n", "<leader>gB", ":G blame<CR>",
                { silent = true, noremap = true }
            )
        end
    }
}
