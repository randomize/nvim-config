return {
  {   -- Formatter - new neoformat fork Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    "mhartington/formatter.nvim",
    cmd = "Format",
    keys = {
      { "<space>f", "<cmd>Format<CR>", desc = "Re-format" },
    },
    config = function(_, _)
      local opts = {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      }
      require("formatter").setup(opts)
    end,
  },
}
