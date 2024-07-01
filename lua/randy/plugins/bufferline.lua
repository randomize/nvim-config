return {
    -- Buffer line
    {
        "akinsho/bufferline.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = {
            options = {
                --separator_style = "slant",
                always_show_bufferline = true,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            vim.keymap.set("n", "<space><space>", ":BufferLinePick<CR>")
        end,
    },
}
