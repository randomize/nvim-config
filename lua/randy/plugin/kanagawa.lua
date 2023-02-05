return {
  -- kanagawa color scheme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("kanagawa").setup(opts)

      -- vim.cmd([[colorscheme kanagawa]])

      -- Data for limelight_conceal
      vim.cmd("let g:limelight_conceal_ctermfg = 'gray'")
      vim.cmd("let g:limelight_conceal_ctermfg = 240")
      vim.cmd("let g:limelight_conceal_guifg = 'DarkGray'")
      vim.cmd("let g:limelight_conceal_guifg = '#777777'")
      vim.cmd("let g:limelight_default_coefficient = 0.9")
    end,
    opts = {
      transparent = true,
      undercurl = true, -- undercurl is enabled by default
      specialReturn = true, -- special highlight for the return keyword
      specialKeyword = true, -- special highlight for the keyword "return"
      specialException = true, -- special highlight for exception handling keywords
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus = 3
      commentStyle = { italic = true }, -- Italicize comments
      functionStyle = { italic = true }, -- Italicize functions
      keywordStyle = { italic = true }, -- Italic Keywords
      statementStyle = { bold = true }, -- Bold is the default for statements.
      typeStyle = { italic = true }, -- Italic is used for type names.
      variablebuiltinStyle = { italic = true }, -- Italic for builtin variables
      colors = {},
      overrides = {
        Normal = { bg = "NONE" },
        NormalNC = { bg = "NONE" },
        Search = { bg = "NONE" },
        StatusLine = { bg = "NONE" },
        StatusLineNC = { bg = "NONE" },
        Special = { bg = "NONE" },
        TelescopeNormal = { bg = "NONE" },
        TelescopeBorder = { bg = "NONE" },
        NeoTreeNormal = { bg = "NONE" },
        NeoTreeNormalNC = { bg = "NONE" },
        NeoTreeTitleBar = { bg = "NONE" },
        NeoTreeFloatNormal = { bg = "NONE" },
        NeoTreeFloatTitle = { bg = "NONE" },
        NeoTreeFloatBorder = { bg = "#000000" },
      },
    },
  },
}
