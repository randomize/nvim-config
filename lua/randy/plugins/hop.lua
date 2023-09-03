return {
    {
        'phaazon/hop.nvim',
        lazy = false,
        branch = "v2",
        config = function()
            require('alpha').setup(require('randy.alpha-theme').config)
            require'hop'.setup {
                keys = 'uhetnosaidpgyfxbkmjwcrlzqv'
            }
        end,
    },
}
