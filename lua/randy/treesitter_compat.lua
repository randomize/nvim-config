local M = {}

local html_script_type_languages = {
    importmap = "json",
    module = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
}

local injection_aliases = {
    ex = "elixir",
    pl = "perl",
    sh = "bash",
    ts = "typescript",
    uxn = "uxntal",
}

local function capture_node(match, id)
    local value = match[id]
    if type(value) == "table" then
        return value[1]
    end
    return value
end

local function valid_args(name, pred, count, strict)
    local arg_count = #pred - 1
    if strict and arg_count ~= count then
        vim.api.nvim_err_writeln(("%s must have exactly %d arguments"):format(name, count))
        return false
    end
    if not strict and arg_count < count then
        vim.api.nvim_err_writeln(("%s must have at least %d arguments"):format(name, count))
        return false
    end
    return true
end

local function markdown_parser(alias)
    local match = vim.filetype.match({ filename = "a." .. alias })
    return match or injection_aliases[alias] or alias
end

function M.setup()
    if vim.fn.has("nvim-0.12") == 0 then
        return
    end

    local query = require("vim.treesitter.query")
    local opts = { force = true, all = false }

    query.add_predicate("nth?", function(match, _, _, pred)
        if not valid_args("nth?", pred, 2, true) then
            return
        end

        local node = capture_node(match, pred[2])
        local n = tonumber(pred[3])
        if node and node:parent() and node:parent():named_child_count() > n then
            return node:parent():named_child(n) == node
        end

        return false
    end, opts)

    query.add_predicate("is?", function(match, _, bufnr, pred)
        if not valid_args("is?", pred, 2) then
            return
        end

        local node = capture_node(match, pred[2])
        if not node then
            return true
        end

        local locals = require("nvim-treesitter.locals")
        local _, _, kind = locals.find_definition(node, bufnr)
        return vim.tbl_contains({ unpack(pred, 3) }, kind)
    end, opts)

    query.add_predicate("kind-eq?", function(match, _, _, pred)
        if not valid_args("kind-eq?", pred, 2) then
            return
        end

        local node = capture_node(match, pred[2])
        return not node or vim.tbl_contains({ unpack(pred, 3) }, node:type())
    end, opts)

    query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
        local node = capture_node(match, pred[2])
        if not node then
            return
        end

        local text = vim.treesitter.get_node_text(node, bufnr)
        local configured = html_script_type_languages[text]
        if configured then
            metadata["injection.language"] = configured
            return
        end

        local parts = vim.split(text, "/", {})
        metadata["injection.language"] = parts[#parts]
    end, opts)

    query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = capture_node(match, pred[2])
        if not node then
            return
        end

        local alias = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = markdown_parser(alias)
    end, opts)

    query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local id = pred[2]
        local node = capture_node(match, id)
        if not node then
            return
        end

        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
        metadata[id] = metadata[id] or {}
        metadata[id].text = text:lower()
    end, opts)
end

return M
