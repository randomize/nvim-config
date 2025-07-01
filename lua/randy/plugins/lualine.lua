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
                    {
                        function()
                            -- safe require so the rest of the line
                            -- still renders if the plugin hasn’t loaded yet
                            local ok, jp = pcall(require, "jsonpath")
                            return ok and jp.get() or ""
                        end,
                        cond = function()
                            local ft = vim.bo.filetype
                            return ft == "json" or ft == "jsonc"
                        end,
                    },
                    "lsp_progress",
                },
            },
        },
    },
}
