return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      {
        "<leader>?",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "[?] Find recently opened files",
      },
      {
        "<leader><space>",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last picker",
      },
      { "<C-S-P>", ":Telescope<CR>", { noremap = true, silent = true, desc = "Telescope" } },
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ hidden = false, no_ignore = true })
        end,
        desc = "Search Files",
      },
      {
        ";",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Search buffers",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      {
        "<leader>sb",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Fuzzily [s]earch in current [b]uffer]",
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
        },
        preview_title = "",
        prompt_title = "",
        results_title = "",
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        -- Use the bellow instead for a non-borders layout
        -- borderchars = {
        --   prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        --   results = { " " },
        --   preview = { " " },
        -- },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      pickers = {
        find_files = {
          preview_title = "",
          prompt_title = "",
          results_title = "",
        },
        help_tags = {
          preview_title = "",
          -- prompt_title = "",
          results_title = "",
        },
        grep_string = {
          preview_title = "",
          -- prompt_title = "",
          results_title = "",
        },
        live_grep = {
          preview_title = "",
          -- prompt_title = "",
          results_title = "",
        },
        diagnostics = {
          preview_title = "",
          -- prompt_title = "",
          results_title = "",
        },
      },
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    init = function()
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
