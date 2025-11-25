return {
    -- Fancier statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            {
                "linrongbin16/lsp-progress.nvim",
                config = function()
                    require("lsp-progress").setup()
                end,
            },
        },
        lazy = false,
        config = function(_, opts)
            local lualine = require("lualine")
            opts.options.theme = 'tokyonight'
            lualine.setup(opts)

            -- refresh the statusline when LSP progress events fire
            if pcall(require, "lsp-progress") then
                local group = vim.api.nvim_create_augroup("randy_lualine_lsp_progress", { clear = true })
                vim.api.nvim_create_autocmd("User", {
                    group = group,
                    pattern = "LspProgressStatusUpdated",
                    callback = function()
                        local ok, lualine_mod = pcall(require, "lualine")
                        if ok then
                            lualine_mod.refresh()
                        end
                    end,
                })
            end
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
                    {
                        function()
                            local ok, progress = pcall(require, "lsp-progress")
                            if not ok then
                                return ""
                            end
                            return progress.progress() or ""
                        end,
                    },
                },
            },
        },
    },
}
