return {
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
        opts = {
            modes =  { insert = false, command = false, terminal = false },
        }
    },
}
