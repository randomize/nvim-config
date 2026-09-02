local M = {}

local function notify(message, level)
    vim.notify(message, level or vim.log.levels.INFO, { title = 'Buffer Convert' })
end

local function shell_join(argv)
    return table.concat(vim.tbl_map(function(arg)
        return vim.fn.shellescape(arg)
    end, argv), ' ')
end

local function executable_or_warn(name)
    if vim.fn.executable(name) == 1 then
        return true
    end

    notify(('Executable not found: %s'):format(name), vim.log.levels.ERROR)
    return false
end

local function read_error_file(path)
    local lines = {}

    if vim.fn.filereadable(path) == 1 then
        lines = vim.fn.readfile(path)
    end

    vim.fn.delete(path)
    return table.concat(lines, '\n')
end

local function run_filter(argv, opts)
    opts = opts or {}

    if not executable_or_warn(argv[1]) then
        return false
    end

    local stderr_path = vim.fn.tempname()
    local command = shell_join(argv) .. ' 2>' .. vim.fn.shellescape(stderr_path)
    local view = vim.fn.winsaveview()

    local ok, command_error = pcall(vim.cmd, 'silent keepjumps %!' .. command)
    local exit_code = vim.v.shell_error
    local stderr = read_error_file(stderr_path)

    if not ok or exit_code ~= 0 then
        if ok then
            pcall(vim.cmd, 'silent undo')
        end

        vim.fn.winrestview(view)

        local message = stderr ~= '' and stderr or tostring(command_error or ('exit code ' .. exit_code))
        notify(message, vim.log.levels.ERROR)
        return false
    end

    if opts.postprocess then
        local postprocess_ok, postprocess_error = pcall(function()
            vim.cmd('silent undojoin')
            opts.postprocess()
        end)

        if not postprocess_ok then
            pcall(vim.cmd, 'silent undo')
            vim.fn.winrestview(view)
            notify(tostring(postprocess_error), vim.log.levels.ERROR)
            return false
        end
    end

    vim.fn.winrestview(view)

    if vim.wo.diff then
        vim.cmd('diffupdate')
    end

    return true
end

local function strip_xxd_offsets()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for index, line in ipairs(lines) do
        local hex, ascii = line:match('^%x+:%s+(%x%x)%s%s(.*)$')

        if not hex then
            error(('Unexpected xxd output on line %d: %s'):format(index, line))
        end

        lines[index] = hex .. ' ' .. ascii
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local function validate_plain_xxd()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for index, line in ipairs(lines) do
        if not line:match('^%x%x$') then
            notify(('Line %d is not plain one-byte xxd: %s'):format(index, line), vim.log.levels.ERROR)
            return false
        end
    end

    return true
end

local transforms = {
    {
        name = 'Hexdump -C',
        description = 'canonical 16-byte rows + ASCII',
        run = function()
            run_filter({ 'hexdump', '-Cv' })
        end,
    },
    {
        name = 'XXD plain',
        description = '1 byte/line; reversible',
        run = function()
            run_filter({ 'xxd', '-p', '-c1' })
        end,
    },
    {
        name = 'XXD + ASCII',
        description = '1 byte/line; no offsets: "41 A"',
        run = function()
            run_filter({ 'xxd', '-g1', '-c1' }, { postprocess = strip_xxd_offsets })
        end,
    },
    {
        name = 'XXD plain -> binary',
        description = 'reverse the 1-byte/line plain form',
        run = function()
            if validate_plain_xxd() then
                run_filter({ 'xxd', '-r', '-p' })
            end
        end,
    },
    {
        name = 'AXML -> XML',
        description = 'decode Android binary manifest with axmldec',
        run = function()
            if not executable_or_warn('axmldec') then
                return
            end

            local path = vim.api.nvim_buf_get_name(0)

            if path == '' then
                notify('AXML decode needs a file-backed buffer', vim.log.levels.ERROR)
                return
            end

            if vim.bo.modified then
                notify('AXML decode reads the file on disk; undo or write buffer changes first', vim.log.levels.WARN)
                return
            end

            if run_filter({ 'axmldec', path }) then
                vim.bo.filetype = 'xml'
            end
        end,
    },
}

function M.pick()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values
    local entry_display = require('telescope.pickers.entry_display')
    local finders = require('telescope.finders')
    local pickers = require('telescope.pickers')
    local themes = require('telescope.themes')

    local displayer = entry_display.create({
        separator = '  ',
        items = {
            { width = 22 },
            { remaining = true },
        },
    })

    local opts = themes.get_dropdown({
        previewer = false,
        layout_config = {
            width = 0.72,
        },
    })

    pickers.new(opts, {
        prompt_title = 'Convert current buffer',
        finder = finders.new_table({
            results = transforms,
            entry_maker = function(transform)
                return {
                    value = transform,
                    ordinal = transform.name .. ' ' .. transform.description,
                    display = function(entry)
                        return displayer({
                            entry.value.name,
                            entry.value.description,
                        })
                    end,
                }
            end,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                if not selection then
                    return
                end

                local picker = action_state.get_current_picker(prompt_bufnr)
                local target_bufnr = picker.original_bufnr

                actions.close(prompt_bufnr)

                vim.schedule(function()
                    if not vim.api.nvim_buf_is_valid(target_bufnr) then
                        return
                    end

                    vim.api.nvim_buf_call(target_bufnr, selection.value.run)
                end)
            end)

            return true
        end,
    }):find()
end

return M
