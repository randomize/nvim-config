local M = {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  opts = {
    filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
  },
  config = function(_, opts)

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
            capabilities = capabilities
            -- you can add other fields for setting up lsp server in this table
        })
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
      pattern = opts.filetype_exclude,
      callback = function()
        require('ufo').detach()
      end,
    })

    vim.opt.foldlevelstart = 99
    require('ufo').setup(opts)
  end,
}

return M
