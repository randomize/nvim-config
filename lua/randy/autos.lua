-- autos.lua
-- contains auto commands and customizations, an helper functions

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.opt_local.list = true
        vim.opt_local.listchars = {
            space = '·',
            tab = '→ ',
            trail = '·',
            extends = '❯',
            precedes = '❮',
            nbsp = '␣',
        }
    end,
})

function RandomHighlightWord()
    local word = vim.fn.expand('<cword>')
    if word == '' then
        return
    end -- Ignore empty words

    -- Generate a random highlight group
    local hlgroup = 'MyHighlight' .. math.random(10000)
    vim.cmd('highlight ' .. hlgroup .. ' ctermfg=' .. math.random(1, 15) .. ' guifg=' .. string.format('#%06x', math.random(0, 0xFFFFFF)))

    -- Apply the highlight to the word
    vim.fn.matchadd(hlgroup, '\\V\\<' .. word .. '\\>')
end

vim.api.nvim_set_keymap('n', '<Space>*', ':lua RandomHighlightWord()<CR>', { noremap = true, silent = true })
