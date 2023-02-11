return {
    -- Displays minor-mode popup for <leader> and 'g'
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = {
                    enabled = true,
                },
            },
        },
    },
}
