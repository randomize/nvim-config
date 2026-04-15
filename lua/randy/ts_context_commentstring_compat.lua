local M = {}

function M.setup()
    if vim.fn.has("nvim-0.12") == 0 then
        return
    end

    local ok, utils = pcall(require, "ts_context_commentstring.utils")
    if not ok or utils._randy_compat_applied then
        return
    end
    utils._randy_compat_applied = true

    local get_cursor_line_non_whitespace_col_location = utils.get_cursor_line_non_whitespace_col_location

    function utils.is_treesitter_active(bufnr)
        bufnr = bufnr or 0
        local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        return parser_ok and parser ~= nil
    end

    function utils.get_node_at_cursor_start_of_line(only_languages, not_nested_languages, location)
        if not utils.is_treesitter_active() then
            return
        end

        location = location or get_cursor_line_non_whitespace_col_location()
        local range = {
            location[1],
            location[2],
            location[1],
            location[2],
        }

        local language_tree = vim.treesitter.get_parser()
        if not language_tree then
            return
        end

        language_tree:for_each_tree(function(_, ltree)
            if
                ltree:contains(range)
                and vim.tbl_contains(only_languages, ltree:lang())
                and not not_nested_languages[language_tree:lang()]
            then
                language_tree = ltree
            end
        end)

        if not language_tree then
            return
        end

        local node = language_tree:named_node_for_range(range)
        return node, language_tree
    end
end

return M
