-- lua/randy/lsp/on_attach.lua
local M = {}

local function attach(client, bufnr)
  ---------------------------------------------------------------------------
  -- Omnisharp: keep your custom semantic‑token legend
  ---------------------------------------------------------------------------
  if client.name == 'omnisharp' then
    client.server_capabilities.semanticTokensProvider = {
      full   = vim.empty_dict(),
      range  = true,
      legend = {
        tokenModifiers = { 'static_symbol' },
        tokenTypes     = {
          -- long list unchanged ⬇
          'comment','excluded_code','identifier','keyword','keyword_control',
          'number','operator','operator_overloaded','preprocessor_keyword',
          'string','whitespace','text','static_symbol','preprocessor_text',
          'punctuation','string_verbatim','string_escape_character','class_name',
          'delegate_name','enum_name','interface_name','module_name','struct_name',
          'type_parameter_name','field_name','enum_member_name','constant_name',
          'local_name','parameter_name','method_name','extension_method_name',
          'property_name','event_name','namespace_name','label_name',
          'xml_doc_comment_attribute_name','xml_doc_comment_attribute_quotes',
          'xml_doc_comment_attribute_value','xml_doc_comment_cdata_section',
          'xml_doc_comment_comment','xml_doc_comment_delimiter',
          'xml_doc_comment_entity_reference','xml_doc_comment_name',
          'xml_doc_comment_processing_instruction','xml_doc_comment_text',
          'xml_literal_attribute_name','xml_literal_attribute_quotes',
          'xml_literal_attribute_value','xml_literal_cdata_section',
          'xml_literal_comment','xml_literal_delimiter',
          'xml_literal_embedded_expression','xml_literal_entity_reference',
          'xml_literal_name','xml_literal_processing_instruction',
          'xml_literal_text','regex_comment','regex_character_class',
          'regex_anchor','regex_quantifier','regex_grouping','regex_alternation',
          'regex_text','regex_self_escaped_character','regex_other_escape',
        },
      }
    }
  end

  ---------------------------------------------------------------------------
  -- key‑maps (exactly what you had before)
  ---------------------------------------------------------------------------
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func,
      { buffer = bufnr, desc = desc and ('LSP: ' .. desc) })
  end

  nmap('<leader>lr', vim.lsp.buf.rename,             '[R]ename')
  nmap('<space>r',    vim.lsp.buf.rename,             '[R]ename')
  nmap('<space>a',    vim.lsp.buf.code_action,        'Code [A]ction')
  nmap('<space>g',    vim.lsp.buf.definition,         '[G]oto [D]efinition')
  nmap('<space>G',    require('omnisharp_extended').telescope_lsp_definitions,
                                                      '[G]odo Definition Telescope')
  nmap('gr',          require('telescope.builtin').lsp_references,            '[G]oto [R]eferences')
  nmap('gI',          vim.lsp.buf.implementation,                             '[G]oto [I]mplementation')
  nmap('<space>i',    vim.lsp.buf.implementation,                             '[G]oto [I]mplementation')
  nmap('<leader>D',   vim.lsp.buf.type_definition,                            'Type [D]efinition')
  nmap('<leader>ld',  require('telescope.builtin').lsp_document_symbols,      '[D]ocument [S]ymbols')
  nmap('<leader>lw',  require('telescope.builtin').lsp_dynamic_workspace_symbols,'[W]orkspace [S]ymbols')
  nmap('<space>u',    require('telescope.builtin').lsp_references,            'Search Usages')
  nmap('<leader>k',   vim.lsp.buf.hover,                                      'Hover Documentation')
  nmap('<leader>lh',  vim.lsp.buf.signature_help,                             'Signature Documentation')
  nmap('<space>G',    vim.lsp.buf.declaration,                                '[G]oto [D]eclaration')
  nmap('<leader>wa',  vim.lsp.buf.add_workspace_folder,                       '[W]orkspace [A]dd Folder')
  nmap('<leader>wr',  vim.lsp.buf.remove_workspace_folder,                    '[W]orkspace [R]emove Folder')
  nmap('<leader>wl',  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                                                                              '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format',
    function() vim.lsp.buf.format() end,
    { desc = 'Format current buffer with LSP' })
end

M.attach = attach
return M
