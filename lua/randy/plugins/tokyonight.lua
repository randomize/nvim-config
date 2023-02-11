return {
    -- Tokyo night theme,
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        config = function(_, opts)
            require("tokyonight").setup(opts)
            -- vim.cmd([[colorscheme tokyonight]])
        end,
        opts = {
            styles = {
                floats = "transparent",
                sidebars = "transparent",
            },
            style = "storm",
            transparent = true,
            sidebars = { "qf", "help", "Whichkey"},
            dim_inactive = true,
            hide_inactive_statusline = false,
            -- on_highlights = function(hl, c)
            --
            --   -- Neovim
            --   hl.Normal = { bg = c.none, fg = c.fg }
            --   hl.NormalNC = { bg = c.none }
            --   hl.NormalFloat = { bg = "#111111", fg = c.fg }
            --   hl.Search = { bg = c.none }
            --   hl.StatusLine = { bg = c.none, fg = c.fg }
            --   hl.StatusLineNC = { bg = c.none, fg = c.fg_gutter }
            --   hl.Special = { fg = c.magenta }
            --
            --   -- Treesitter
            --   hl.Type = { fg = c.magenta }
            --   -- hl.Identifier = { fg = c.blue }
            --   -- hl.Statement = { fg = c.blue }
            --   -- hl["@constructor"] = { fg = c.blue }
            --   hl["@keyword"] = { fg = c.blue5 }
            --   hl["@parameter"] = { fg = c.fg }
            --   hl["@property"] = { fg = c.fg }
            --   hl["@constructor"] = { fg = c.blue1 }
            --
            --   -- Telescope
            --   hl.TelescopeNormal = { bg = c.none, fg = c.fg }
            --   hl.TelescopeBorder = { bg = c.none, fg = c.fg }
            --
            --   -- Neotree
            --   hl.NeoTreeNormal = { bg = c.none, fg = c.fg }
            --   hl.NeoTreeNormalNC = { bg = c.none, fg = c.fg }
            --   hl.NeoTreeTitleBar = { bg = c.bg_popup, fg = c.fg }
            --   hl.NeoTreeFloatNormal = { bg = c.none, fg = c.fg }
            --   hl.NeoTreeFloatTitle = { bg = c.none, fg = c.fg }
            --   hl.NeoTreeFloatBorder = { bg = "#000000", fg = c.fg_dark }
            --
            --   -- Whichkey
            --   hl.WhichKeyFloat = { bg = c.none, fg = c.fg }
            --
            --   -- Mason
            --   hl.MasonHeader = { bg = "#111111" }
            -- end,
        },
    },
}
