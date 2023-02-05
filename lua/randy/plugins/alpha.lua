return {
  {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function ()
      require'alpha'.setup(require'ara.alpha-theme'.config)
    end
  }
}
