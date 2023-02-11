return {
    -- Outline plugin for LSP
    "simrat39/symbols-outline.nvim",
    lazy = false,
    config = function(_, opts)
        require("symbols-outline").setup(opts)
    end,
    opts = {
        width = 30,
    },
}
