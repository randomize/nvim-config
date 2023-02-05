return {
  -- Add indentation guides even on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      char = "", -- other scopes
      context_char = "┊", -- the current scope
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = false,
    },
  },
}
