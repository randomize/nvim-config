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
            --
            'folke/neoconf.nvim'
        },

        config = function()

            -- First configure neoconf
            require("neoconf").setup({
                plugins = {
                    lspconfig = {
                        enabled = false,
                    },
                },
            })

            -------------------------------------------------------------
            -- capabilities & on_attach
            -------------------------------------------------------------
            local on_attach_local   = require('randy.lsp.on_attach').attach
            local root_dir = require('randy.lsp.root_dir')
            local capabilities = require('cmp_nvim_lsp').default_capabilities(
                vim.lsp.protocol.make_client_capabilities())

            -- still required for ufo folding
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly     = true,
            }

            -------------------------------------------------------------
            -- servers configuration
            -------------------------------------------------------------
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                on_attach = on_attach_local,
                settings = {
                    Lua = {
                        workspace   = { checkThirdParty = false },
                        diagnostics = { globals = { 'vim' } },
                    },
                },
            })

            vim.lsp.config('basedpyright', {
                capabilities = capabilities,
                on_attach = on_attach_local,
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config('jsonls', {
                capabilities = capabilities,
                on_attach    = on_attach_local,
                settings = {
                    json = {
                        schemas  = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })


            vim.lsp.config('omnisharp', {
                capabilities = capabilities,
                on_attach = on_attach_local,
                cmd = { 'omnisharp' },
                single_file_support = false,
                root_dir = function(fname, bufnr)
                    return root_dir(fname, bufnr)
                end,
                handlers = {
                    ['textDocument/definition'] = require('omnisharp_extended').handler,
                },
            })

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
                        on_attach    = on_attach_local,
                    }
                end,
            })

            -------------------------------------------------------------
            -- mason bootstrap
            -------------------------------------------------------------
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'jsonls',
                    'bashls',
                    'rust_analyzer',
                    'basedpyright',
                    'omnisharp',
                },
                -- automatic_enable defaults to true in v2; leaving it implicit is fine
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
