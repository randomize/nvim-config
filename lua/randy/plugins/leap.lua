return {
  {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = { "tpope/vim-repeat" },
    opts = {},                    -- tune Leap opts here
    config = function()
      require("leap").add_default_mappings()
    end,
  },
}
