return {
    -- Project management
    {
        "DrKJeff16/project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        lazy = false,
        keys = {
            { "<leader>op", ":Telescope projects<CR>", { noremap = true, silent = true, desc = "[O]pen [P]roject" } },
        },
        config = function()
            require("project_nvim").setup({
                manual_mode = true,
            })

            -- Enable Telescope integration
            require("telescope").load_extension("projects")
        end,
    },
}
