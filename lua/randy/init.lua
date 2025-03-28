require('randy.set')
require('randy.remap')
require('randy.autos')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = "randy.plugins" },
    },
    defaults = {
        lazy = true,   -- determines if every plugin is lazy-loaded by default
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", } },
    checker = { enabled = false }, -- automatically check for plugin updates
    change_detection = { enabled = true, notify = false },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
            },
        },
    },
})

function RandomHighlightWord()
    local word = vim.fn.expand("<cword>")
    if word == "" then return end  -- Ignore empty words

    -- Generate a random highlight group
    local hlgroup = "MyHighlight" .. math.random(10000)
    vim.cmd("highlight " .. hlgroup .. " ctermfg=" .. math.random(1, 15) .. " guifg=" .. string.format("#%06x", math.random(0, 0xFFFFFF)))

    -- Apply the highlight to the word
    vim.fn.matchadd(hlgroup, "\\V\\<" .. word .. "\\>")
end

vim.api.nvim_set_keymap("n", "<Space>*", ":lua RandomHighlightWord()<CR>", { noremap = true, silent = true })
