return {
  -- "gc" to comment visual regions/lines
  -- {
  --   "echasnovski/mini.comment",
  --   event = "VeryLazy",
  --   opts = {
  --     hooks = {
  --       pre = function()
  --         require("ts_context_commentstring.internal").update_commentstring({})
  --       end,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("mini.comment").setup(opts)
  --   end,
  -- },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  }
}
