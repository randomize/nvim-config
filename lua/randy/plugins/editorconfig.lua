return {
  -- Automatically adjust buffer indentation settings when .editorconfig file is available
  -- NOTE: This plugin won't be necessary after neovim 0.9+ as this functionality will
  -- be built-in
  {
    'gpanders/editorconfig.nvim',
    event = 'BufReadPre',
    config = false
  }
}
