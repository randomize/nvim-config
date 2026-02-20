return {
  {
    -- "ggandor/leap.nvim",
    url = "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    dependencies = { "tpope/vim-repeat" },
    opts = {
      labels = [[oubhtndre,.cmxgfkpiya'ljq;/OUBHTNDRE<>CMXGFKPIYA"LJQ:?]],
      safe_labels = "",
    },
    config = function(_, opts)
      local leap = require("leap")

      -- apply your options
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end

      -- manual default mappings (what add_default_mappings() used to do)
      vim.keymap.set({ "n", "x", "o" }, "s",  "<Plug>(leap-forward-to)")
      vim.keymap.set({ "n", "x", "o" }, "S",  "<Plug>(leap-backward-to)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
  },
}
