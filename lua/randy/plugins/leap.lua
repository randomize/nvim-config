return {
  {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = { "tpope/vim-repeat" },
    opts = {
      labels = [[oubhtndre,.cmxgfkpiya'ljq;/OUBHTNDRE<>CMXGFKPIYA"LJQ:?]],
      safe_labels = ''
    },                    -- tune Leap opts here
    init = function(_, opts)
      require("leap").opts = opts
      require("leap").add_default_mappings()
    end,
  },
}
