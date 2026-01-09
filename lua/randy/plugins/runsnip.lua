return {
  "michaelb/sniprun",
  build = "sh install.sh 1",          -- builds the Rust backend once
  keys = {
    { "<space>r", ":'<,'>SnipRun<CR>", mode = "v", desc = "SnipRun selection" },
    {
      ",r",
      function()
        vim.cmd(string.format("%d,%dSnipRun", vim.fn.line("."), vim.fn.line(".")))
      end,
      desc = "SnipRun current line",
    },
  },
  opts = {
    display = { "TempFloatingWindow" },      -- or "Terminal"
    repl_enable = { "bash", "python", "cpp" },
    interpreter_options = {
      Generic = {
        error_truncate = "long",
        PowerShell = {
          supported_filetypes = { "powershell", "ps1" },
          extension = ".ps1",
          interpreter = "pwsh -NoProfile -File",
          compiler = "",
        },
      },
    },
  }
}
