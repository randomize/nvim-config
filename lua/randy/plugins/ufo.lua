return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufReadPost',
    opts = {
        filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
    },
    config = function(_, opts)
        -- DO **NOT** re-setup lsp servers here, you already do that in lua/randy/plugins/lsp.lua

        -- detach ufo on some filetypes (your original logic)
        if opts.filetype_exclude then
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
                pattern = opts.filetype_exclude,
                callback = function()
                    require('ufo').detach()
                end,
            })
            -- don't pass this down as an unknown option
            opts.filetype_exclude = nil
        end

        -- sane defaults recommended by ufo
        vim.o.foldcolumn = '1' -- show fold column
        vim.o.foldlevel = 99 -- high so folds start open
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require('ufo').setup(opts or {})
        -- when OmniSharp attaches, re-enable folds for that buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('ufo_refresh_on_omnisharp', { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client or client.name ~= 'omnisharp' then
                    return
                end

                local ok, ufo = pcall(require, 'ufo')
                if not ok then
                    return
                end

                -- force ufo to (re)request folds from LSP provider for this buffer
                ufo.enableFold(args.buf)
            end,
        })
    end,
}
