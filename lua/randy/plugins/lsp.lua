local root_dir = require("randy.lsp.root_dir")

-- on_attach = function(client, _)
--     print("Hello I am attached")
--     local function toSnakeCase(str) return string.gsub(str, "%s*[- ]%s*", "_") end
--     local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
--     for i, v in ipairs(tokenModifiers) do
--       tokenModifiers[i] = toSnakeCase(v)
--     end
--     local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
--     for i, v in ipairs(tokenTypes) do tokenTypes[i] = toSnakeCase(v) end
-- end,

local custom_mappings_on_attach = function(client, bufnr)

    if client.name == "omnisharp" then
        print("client is omnisharp")
        client.server_capabilities.semanticTokensProvider = {
          full = vim.empty_dict(),
          legend = {
            tokenModifiers = { "static_symbol" },
            tokenTypes = {
              "comment",
              "excluded_code",
              "identifier",
              "keyword",
              "keyword_control",
              "number",
              "operator",
              "operator_overloaded",
              "preprocessor_keyword",
              "string",
              "whitespace",
              "text",
              "static_symbol",
              "preprocessor_text",
              "punctuation",
              "string_verbatim",
              "string_escape_character",
              "class_name",
              "delegate_name",
              "enum_name",
              "interface_name",
              "module_name",
              "struct_name",
              "type_parameter_name",
              "field_name",
              "enum_member_name",
              "constant_name",
              "local_name",
              "parameter_name",
              "method_name",
              "extension_method_name",
              "property_name",
              "event_name",
              "namespace_name",
              "label_name",
              "xml_doc_comment_attribute_name",
              "xml_doc_comment_attribute_quotes",
              "xml_doc_comment_attribute_value",
              "xml_doc_comment_cdata_section",
              "xml_doc_comment_comment",
              "xml_doc_comment_delimiter",
              "xml_doc_comment_entity_reference",
              "xml_doc_comment_name",
              "xml_doc_comment_processing_instruction",
              "xml_doc_comment_text",
              "xml_literal_attribute_name",
              "xml_literal_attribute_quotes",
              "xml_literal_attribute_value",
              "xml_literal_cdata_section",
              "xml_literal_comment",
              "xml_literal_delimiter",
              "xml_literal_embedded_expression",
              "xml_literal_entity_reference",
              "xml_literal_name",
              "xml_literal_processing_instruction",
              "xml_literal_text",
              "regex_comment",
              "regex_character_class",
              "regex_anchor",
              "regex_quantifier",
              "regex_grouping",
              "regex_alternation",
              "regex_text",
              "regex_self_escaped_character",
              "regex_other_escape",
            },
          },
          range = true,
        }
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>r", vim.lsp.buf.rename, "[R]ename")
    -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    nmap("<space>a", vim.lsp.buf.code_action, "Code [A]ction")
    -- nmap("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("<space>g", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gd", require('omnisharp_extended').telescope_lsp_definitions, "[G]o[d]o Definition Telescope")

    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<space>i", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("<C-t>", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("gu", require("telescope.builtin").lsp_references, "Search Usages")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Do[K]umentation")
    nmap("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("<space>G", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

end



return {
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            {"neovim/nvim-lspconfig", branch="master"},
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "Hoffs/omnisharp-extended-lsp.nvim",
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
        lazy = false,
        config = function()
            local lsp = require("lsp-zero")
            -- print('configure lsp doing....')
            lsp.preset("recommended")
            lsp.on_attach(function(client, bufnr) custom_mappings_on_attach(client, bufnr) end)
            lsp.nvim_workspace()

            lsp.ensure_installed({
                'tsserver',
                'rust_analyzer',
                'lua_ls',
                --'azure_pipelines_ls'
            })

            lsp.configure('azure_pipelines_ls', {
                force_setup = true,
                cmd = {'node', '/home/randy/.node_modules/lib/node_modules/azure-pipelines-language-server/out/server.js', '--stdio'},
                settings = {
                   yaml = {
                       schemas = {
                           ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                               "/azure-*.yml",
                               "Azure-Pipelines/**/*.y*l",
                               "Pipelines/*.y*l",
                           },
                       },
                   },
               },
            })

            lsp.configure('omnisharp', {
                root_dir = root_dir,
                on_attach = function(client, bufnr) custom_mappings_on_attach(client, bufnr) end,
                handlers = {
                    ["textDocument/definition"] = require('omnisharp_extended').handler
                },
            })

            lsp.configure('lua_ls', {
                on_attach = function(client, bufnr)
                    print('hello lua_ls')
                end,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'},
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lsp.setup()
            vim.diagnostic.config { virtual_text = true, update_in_insert = false }

            lsp.new_server({
              name = 'randy-packs-lsp',
              cmd = {'/home/randy/Documents/rdev/lsp-hello/tower-lsp-boilerplate/target/debug/nrs-language-server'},
              filetypes = {'randypacks'},
              root_dir = function()
                -- return lsp.dir.find_first({'some-config-file'}) 
                return "/home/randy/dots/nfo"
              end
            })

        end
    }
}
