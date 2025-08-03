-- lua/randy/plugins/lsp.lua
return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- completion stack (see next section)
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      -- helpers
      'Hoffs/omnisharp-extended-lsp.nvim',
      'lukas-reineke/lsp-format.nvim',
      'b0o/schemastore.nvim',
    },

    config = function()
      -------------------------------------------------------------
      -- capabilities & on_attach
      -------------------------------------------------------------
      local on_attach   = require('randy.lsp.on_attach').attach
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
                             vim.lsp.protocol.make_client_capabilities())

      -- still required for ufo folding
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly     = true,
      }

      -------------------------------------------------------------
      -- mason bootstrap
      -------------------------------------------------------------
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'jsonls',
          'bashls',
          'rust_analyzer',
        },

        handlers = {
          -------------------------------------------------------------------
          -- default handler
          -------------------------------------------------------------------
          function(server)
            require('lspconfig')[server].setup {
              capabilities = capabilities,
              on_attach    = on_attach,
            }
          end,

          -------------------------------------------------------------------
          -- lua_ls
          -------------------------------------------------------------------
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup {
              capabilities = capabilities,
              on_attach    = on_attach,
              settings = {
                Lua = {
                  workspace   = { checkThirdParty = false },
                  diagnostics = { globals = { 'vim' } },
                },
              },
            }
          end,

          -------------------------------------------------------------------
          -- jsonls
          -------------------------------------------------------------------
          ['jsonls'] = function()
            require('lspconfig').jsonls.setup {
              capabilities = capabilities,
              on_attach    = on_attach,
              settings = {
                json = {
                  schemas  = require('schemastore').json.schemas(),
                  validate = { enable = true },
                },
              },
            }
          end,
        },
      }

      -------------------------------------------------------------
      -- Omnisharp
      -------------------------------------------------------------
      local root_dir = require('randy.lsp.root_dir')

      require('lspconfig').omnisharp.setup {
        single_file_support = false,
        cmd        = { 'omnisharp' },                -- Mason supplies real path
        root_dir   = function(fname, bufnr)
          -- temporary hard‑code stays; swap back later
          -- return '/mnt/data/work/unified/Unity.Product.UnifiedGolf'
          return root_dir(fname, bufnr)
        end,
        capabilities = capabilities,
        on_attach    = on_attach,
        handlers     = {
          ['textDocument/definition'] = require('omnisharp_extended').handler,
        },
      }

      -------------------------------------------------------------
      -- Your custom "randy‑packs" server
      -------------------------------------------------------------
      vim.api.nvim_create_autocmd('FileType', {
        pattern  = 'randypacks',
        callback = function()
          vim.lsp.start {
            name        = 'randy-packs-lsp',
            cmd         = { '/home/randy/Documents/rdev/lsp-hello/tower-lsp-boilerplate/target/debug/nrs-language-server' },
            root_dir    = '/home/randy/dots/nfo',
            filetypes   = { 'randypacks' },
            capabilities = capabilities,
            on_attach    = on_attach,
          }
        end,
      })

      -------------------------------------------------------------
      -- Diagnostics visuals
      -------------------------------------------------------------
      vim.diagnostic.config {
        virtual_text     = true,
        update_in_insert = false,
        severity_sort    = true,
      }
    end,
  },
}
