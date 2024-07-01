return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      -- numhl = true, -- uncomment to change the color of the numbers based on git diff
      signcolumn = true, -- show signs in the signcolumn
      sign_priority = 6,
      signs = {
        add = { text = "│", },
        change = { text = "│", },
        delete = { text = "_", },
        topdelete = { text = "‾", },
        changedelete = { text = "~", },
        untracked = { text = "┆", },
      },
      -- Alternative sign text
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
    },
  },
}
