return {
{
  "nvim-neorg/neorg",
  lazy = false,
  -- parser rocks must load first so their dirs are on package.cpath when neorg looks up the parsers
  dependencies = { "nvim-lua/plenary.nvim", "tree-sitter-norg", "tree-sitter-norg-meta" },
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
