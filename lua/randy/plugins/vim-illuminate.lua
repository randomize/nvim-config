return {
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        opts = {
            delay = 200,
            min_count_to_highlight = 2,
            large_file_cutoff = 5000,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
                    pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
                end,
            })
        end,
        -- stylua: ignore
        keys = {
            { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
            { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
        },
    },
}
