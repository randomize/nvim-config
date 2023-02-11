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

            -- define a custom color theme based on lualine's builtin 'auto' theme.
            -- the main purpose is to make the background transparent in all modes.
            local original_theme = require("lualine.themes.auto")

            -- clone the default theme
            local custom_theme = vim.tbl_deep_extend("force", original_theme, {})

            local custom_colors = {
                background = nil,
                foreground = nil,
            }

            custom_theme.normal.a.bg = custom_colors.background
            -- custom_theme.normal.a.fg = custom_colors.foreground
            custom_theme.normal.b.bg = custom_colors.background
            custom_theme.normal.b.fg = custom_colors.foreground
            custom_theme.normal.c.bg = custom_colors.background
            -- custom_theme.normal.c.fg = custom_colors.foreground

            custom_theme.command.a.bg = custom_colors.background
            custom_theme.command.a.fg = custom_theme.normal.b.fg
            custom_theme.command.b.bg = custom_colors.background
            custom_theme.command.b.fg = custom_colors.foreground

            custom_theme.insert.a.bg = custom_colors.background
            custom_theme.insert.a.fg = custom_theme.normal.b.fg
            custom_theme.insert.b.bg = custom_colors.background
            custom_theme.insert.b.fg = custom_colors.foreground
            -- custom_theme.insert.c.bg = custom_colors.background

            custom_theme.replace.a.bg = custom_colors.background
            custom_theme.replace.b.bg = custom_colors.background
            -- custom_theme.replace.c.bg = custom_colors.background

            custom_theme.visual.a.bg = custom_colors.background
            -- custom_theme.visual.a.fg = custom_colors.foreground
            custom_theme.visual.b.bg = custom_colors.background
            -- custom_theme.visual.b.fg = custom_colors.foreground
            -- custom_theme.visual.c.bg = custom_colors.background

            custom_theme.inactive.a.bg = custom_colors.background
            custom_theme.inactive.b.bg = custom_colors.background
            custom_theme.inactive.c.bg = custom_colors.background

            custom_theme.normal.x = { fg = custom_theme.normal.a.fg }
            custom_theme.normal.y = { fg = custom_theme.normal.b.fg }
            custom_theme.normal.y = { fg = custom_theme.normal.b.fg }

            custom_theme.normal.z = { fg = custom_theme.normal.b.fg }

            -- custom_theme.insert.x = { fg = custom_theme.normal.a.fg }
            -- custom_theme.insert.y = { fg = custom_theme.normal.b.fg }
            custom_theme.insert.z = { fg = custom_theme.normal.b.fg }

            opts.options.theme = custom_theme
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
