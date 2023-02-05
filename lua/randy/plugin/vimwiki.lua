return {
  -- Personal wiki
  {
    'vimwiki/vimwiki',
    lazy = true,
    keys = {
      '<leader>ww', '<leader>wt'
    },
    cmd = { 'VimwikiIndex', 'VimwikiTabIndex' },
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '$HOME/vimwiki',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  }
}
