return {
  -- Project management
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>op", ":Telescope projects<CR>", { noremap = true, silent = true, desc = "[O]pen [P]roject" } },
    },
    config = function()
      require("project_nvim").setup({})

      -- Enable Telescope integration
      require("telescope").load_extension("projects")
    end,
  },
}
