# Modern Lazy-based neovim configuration

* Luarocks managed by Lazy (no need to have luarocks.nvim), used by rest.nvim mostly


# TODO: Review this list of plugins and decide if I need them (from old packer I guess)


```lua
-- This is only used as library of plugins to review and setup,
-- TODO: review and delete it

return require("packer").startup(function(use)
  use("theprimeagen/harpoon")
  use("mbbill/undotree")

  use("numToStr/Comment.nvim")
  use("kylechui/nvim-surround") -- possible replaced with mini.surround
  use("rstacruz/vim-closer")

  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  })

end)
```


