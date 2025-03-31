return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        ft = {
            "cs",
        },
        config = function() require("copilot").setup {} end,
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                config = function() require("copilot_cmp").setup() end,

            },
        }
    }
}
