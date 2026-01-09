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
            local on_attach_user = require('randy.lsp.on_attach').attach
            local root_dir_local = require('randy.lsp.root_dir')
            local lsp_format     = require('lsp-format')
            lsp_format.setup({})
            local function on_attach_local(client, bufnr)
                on_attach_user(client, bufnr)
                lsp_format.on_attach(client, bufnr)
            end
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

            local clangd_capabilities = vim.deepcopy(capabilities)
            clangd_capabilities.offsetEncoding = { "utf-16" }
            vim.lsp.config('clangd', {
                capabilities = clangd_capabilities,
                on_attach = on_attach_local,

                -- nice defaults
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                },
            })

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
            vim.lsp.enable('lua_ls')

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
            vim.lsp.enable('basedpyright')

            vim.lsp.config('jsonls', {
                capabilities = capabilities,
                on_attach    = on_attach_local,
                settings     = {
                    json = {
                        schemas  = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable('jsonls')

            -- local pid = vim.fn.getpid()
            -- local omnisharp_bin = vim.fn.exepath('omnisharp')  -- uses /usr/bin/omnisharp from pacman (or mason if PATH has it first)
            vim.lsp.config('omnisharp', {
                capabilities = capabilities,
                on_attach = on_attach_local,
                -- cmd = { 'omnisharp' }, -- no longer needed mason will handle
                -- cmd = {
                --     omnisharp_bin,
                --     '--languageserver',
                --     '--hostPID',
                --     tostring(pid),
                -- },
                single_file_support = false,
                root_dir = root_dir_local,
                handlers = {
                    ['textDocument/definition'] = require('omnisharp_extended').handler,
                },
            })
            -- explicitly enable omnisharp (don’t rely on mason auto-enable here)
            vim.lsp.enable('omnisharp')

            vim.lsp.config('html', {
                capabilities = capabilities,
                on_attach = on_attach_local,
            })
            -------------------------------------------------------------
            -- Your custom "randy‑packs" server
            -------------------------------------------------------------
            local randypacks_cmd =
            '/home/randy/Documents/rdev/lsp-hello/tower-lsp-boilerplate/target/debug/nrs-language-server'
            vim.api.nvim_create_autocmd('FileType', {
                pattern  = 'randypacks',
                callback = function()
                    if not vim.loop.fs_stat(randypacks_cmd) then
                        vim.notify_once(
                            ('randy-packs-lsp skipped: binary not found at %s'):format(randypacks_cmd),
                            vim.log.levels.WARN
                        )
                        return
                    end

                    local buf = vim.api.nvim_get_current_buf()
                    local bufname = vim.api.nvim_buf_get_name(buf)
                    local root_dir = bufname ~= '' and vim.fn.fnamemodify(bufname, ':p:h') or vim.loop.cwd()
                    vim.lsp.start {
                        name         = 'randy-packs-lsp',
                        cmd          = { randypacks_cmd },
                        root_dir     = root_dir,
                        filetypes    = { 'randypacks' },
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
                    'clangd',
                    'lua_ls',
                    'jsonls',
                    'bashls',
                    'rust_analyzer',
                    'basedpyright',
                    'omnisharp',
                    'html',
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
