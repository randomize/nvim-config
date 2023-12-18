return {
--[[
  'LhKipp/nvim-nu',
  lazy = true,
  ft = 'nu',
  build = ":TSInstall nu",
  keys = { { 'K', vim.lsp.buf.hover, silent = true, buffer = true } },
  dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
  config = function()
    require('nu').setup({ use_lsp_features = true })
  end
    ]]--
}
