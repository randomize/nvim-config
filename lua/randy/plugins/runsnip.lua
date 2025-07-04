return {
  "michaelb/sniprun",
  build = "sh install.sh 1",          -- builds the Rust backend once
  keys = {
    { "<space>r", ":'<,'>SnipRun<CR>", mode = "v", desc = "SnipRun selection" },
  },
  opts = {
    display = { "TempFloatingWindow" },      -- or "Terminal"
    repl_enable = { "bash", "python", "cpp" }
  }
}
