return {
    {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        lazy = true,
        config = function()
            require('alpha').setup(require('randy.alpha-theme').config)
        end,
    },
}
