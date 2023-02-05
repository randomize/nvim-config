return {
    {
        "AndrewRadev/switch.vim",
        cmd = { "Switch" },
        init = function()
            vim.g.switch_mapping = "<space>t"
        end,
        keys = { "<space>t" },
    },
}
