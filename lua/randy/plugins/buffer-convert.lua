return {
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            {
                '<leader>uk',
                function()
                    require('randy.buffer_convert').pick()
                end,
                desc = 'Convert current buffer',
            },
        },
    },
}
