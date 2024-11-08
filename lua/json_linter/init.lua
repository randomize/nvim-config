-- ~/.config/nvim/lua/json_linter/init.lua

local json_linter = {}

-- Create a namespace for highlights and virtual text
local ns_id = vim.api.nvim_create_namespace("json_linter")

-- Lint function to check paths in a JSON file
function json_linter.lint_json_paths()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local json_string = table.concat(lines, "\n")

    -- Decode JSON
    local ok, json_data = pcall(vim.fn.json_decode, json_string)
    if not ok then
        print("Error decoding JSON")
        return
    end

    local issues = {}

    -- Function to check paths and capture exact line numbers
    local function check_paths(data, current_path, line_lookup)
        if type(data) == "string" and data:match("^/") then
            if vim.fn.isdirectory(data) == 0 then
                local line_num = line_lookup[data]
                table.insert(issues, { path = data, json_path = current_path, line = line_num })
            end
        elseif type(data) == "table" then
            for k, v in pairs(data) do
                check_paths(v, (current_path and current_path .. "." or "") .. k, line_lookup)
            end
        end
    end

    -- Create a line lookup table for all the strings in the JSON
    local line_lookup = {}
    for lnum, line in ipairs(lines) do
        for path in line:gmatch('"/.-"') do
            local clean_path = path:match('^"(/.-)"$')
            if clean_path then
                line_lookup[clean_path] = lnum
            end
        end
    end

    -- Check paths with correct line number association
    check_paths(json_data, nil, line_lookup)

    -- Populate quickfix list if there are any issues
    if #issues > 0 then
        json_linter.populate_quickfix(issues)
    else
        -- print("No issues found.")
    end
end

-- Populate the quickfix list with issues
function json_linter.populate_quickfix(issues)
    local qflist = {}

    for _, issue in ipairs(issues) do
        table.insert(qflist, {
            filename = vim.api.nvim_buf_get_name(0),
            lnum = issue.line,
            col = 0,
            text = "Invalid path: " .. issue.path .. " in JSON key: " .. issue.json_path
        })
    end

    vim.fn.setqflist(qflist, 'r')
    vim.cmd("copen")
end

-- Highlight invalid paths with virtual text (squiggly lines)
function json_linter.highlight_invalid_paths()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Create highlight group for squiggly lines
    vim.cmd([[highlight InvalidPathSquiggle guisp=Red gui=undercurl]])

    -- Clear any existing virtual text or highlights
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    for lnum, line in ipairs(lines) do
        for path in line:gmatch('"/.-"') do
            local clean_path = path:match('^"(/.-)"$')
            if clean_path and vim.fn.isdirectory(clean_path) == 0 then
                local col_start = line:find(path, 1, true)
                if col_start then
                    -- Add squiggly underline using virtual text
                    vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, col_start, {
                        virt_text = { { "~~~~~~~~", "InvalidPathSquiggle" } },  -- Squiggly underline
                        virt_text_pos = 'overlay',
                        hl_mode = "combine"
                    })
                end
            end
        end
    end
end

return json_linter
