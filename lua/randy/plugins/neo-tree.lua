return {
    { -- File Explorer
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        cmd = "Neotree",
        keys = {
            { "-", "<cmd>Neotree float toggle reveal=true<CR>", desc = "File Explorer" },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        config = function(_, opts)
            require("neo-tree").setup(opts)
            require("window-picker").setup({})
        end,
        opts = {
            popup_border_style = "single",
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                    -- hide_by_name = {
                    --   "node_modules"
                    -- },
                    never_show = {
                        "node_modules",
                    },
                },
                follow_current_file = true,
            },
            buffers = {
                follow_current_file = true,
            },
        },
    },
}
