return {
    {
        "numToStr/BufOnly.nvim",
        cmd = { "BufOnly" },
        init = function()
            vim.g.bufonly_delete_non_modifiable = true
            vim.keymap.set("n", "<space>o", "<cmd>BufOnly<CR>", { noremap = true, silent = true, desc = 'This Buffer Only'})
        end,
        keys = { "<space>o" },
    },
}
