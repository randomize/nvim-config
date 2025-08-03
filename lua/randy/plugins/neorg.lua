return {
{
  "nvim-neorg/neorg",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  priority = 1001,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = { notes = "~/notes" },
        },
      },
    },
  },
  config = function(_, opts)
    require("neorg").setup(opts)   -- lazy passes your opts table in
  end,
}
}
