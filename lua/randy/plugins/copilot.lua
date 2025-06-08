return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",              -- load when you start typing
    opts = {
      -- show ghost-text while you’re still wiring cmp:
      suggestion = { enabled = true, auto_trigger = true },
      panel      = { enabled = false },
      filetypes  = {                     -- enable for the languages you care about
        sh     = true,                   -- bash/zsh
        python = true,
        cs     = true,
        ["*"]  = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      require("copilot_cmp").setup()     -- bridge to nvim-cmp
    end,
    dependencies = { "zbirenbaum/copilot-cmp" },
  },
}
