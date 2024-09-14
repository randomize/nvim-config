
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.list = true
    vim.opt_local.listchars = {
      space = '·',
      tab = '→ ',
      trail = '·',
      extends = '❯',
      precedes = '❮',
      nbsp = '␣',
    }
  end,
})
