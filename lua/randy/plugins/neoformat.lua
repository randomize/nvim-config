return {
    { -- Formatter - new neoformat fork Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        "sbdchd/neoformat",
        cmd = "Format",
        lazy = false,
        keys = {
            { "<space>F", "<cmd>NeoFormat<CR>", desc = "Re-format" },
        },
        config = function(_, _)
            --require("formatter").setup(opts)
        end,
    },
}
