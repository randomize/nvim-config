return {
    -- Fancier statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            -- "WhoIsSethDaniel/lualine-lsp-progress.nvim"
        },
        lazy = false,
        config = function(_, opts)
            local lualine = require("lualine")
            opts.options.theme = 'tokyonight'
            lualine.setup(opts)
        end,
        opts = {
            options = {
                icons_enabled = true,
                component_separators = " ",
                section_separators = "",
            },
            sections = {
                lualine_c = {
                    "filename",
                    "lsp_progress",
                },
            },
        },
    },
}
