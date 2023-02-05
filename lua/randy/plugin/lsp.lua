local install_servers = {
  jsonls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },
  clangd = {},
  gopls = {},
  omnisharp = {
    -- enable_editorconfig_support = true,
    enable_roslyn_analyzers = false,
    -- enable_import_completion = false,
    filetypes = { "cs", "csx", "vb" },
  },
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>r", vim.lsp.buf.rename, "[R]ename")
  -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  nmap("<C-t>", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  nmap("gu", require("telescope.builtin").lsp_references, "Search Usages")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      { "b0o/SchemaStore.nvim", version = false }, -- last release is way too old
      "jose-elias-alvarez/typescript.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      servers = install_servers,
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- setup for typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- -- setup formatting and keymaps
      -- require("lazyvim.util").on_attach(function(client, buffer)
      --   require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
      --   require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      -- end)

      -- diagnostics
      local signs = { Error = "● ", Warn = "● ", Hint = " ", Info = " " }
      for name, icon in pairs(signs) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities =
      require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
      require("mason-lspconfig").setup_handlers({
        function(server)
          local server_opts = servers[server] or {}
          server_opts.capabilities = capabilities
          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return
            end
          elseif opts.setup["*"] then
            if opts.setup["*"](server, server_opts) then
              return
            end
          end

          -- Use omnishart_extended to be able to decompile/go to definition of 3rd party libraries
          if server == "omnisharp" then
            server_opts.handlers = {
              ["textDocument/definition"] = require("omnisharp_extended").handler,
            }
          end

          server_opts.on_attach = on_attach
          require("lspconfig")[server].setup(server_opts)
        end,
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
          -- the following requires the jose-elias-alvarez/typescript.nvim plugin
          require("typescript.extensions.null-ls.code-actions"),
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = vim.tbl_keys(install_servers),
    },
    -- ---@param opts MasonSettings | {ensure_installed: string[]}
    -- config = function(_, opts)
    --   require("mason").setup(opts)
    --   local mr = require("mason-registry")
    --   for _, tool in ipairs(opts.ensure_installed) do
    --     local p = mr.get_package(tool)
    --     if not p:is_installed() then
    --       p:install()
    --     end
    --   end
    -- end,
  },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true, event = "VeryLazy" },
}
-- return {
--   {
--     -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     dependencies = {
--       -- Automatically install LSPs to stdpath for neovim
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--
--       -- Useful status updates for LSP
--       'j-hui/fidget.nvim',
--
--       -- Additional lua configuration, makes nvim stuff amazing
--       'folke/neodev.nvim',
--     },
--   },
--
--   -- Extended textDocument/definition handler that handles assembly/decompilation loading for $metadata$ documents.
--   { 'Hoffs/omnisharp-extended-lsp.nvim' },
-- }
