return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            -- numhl = true, -- uncomment to change the color of the numbers based on git diff
            signcolumn = true, -- show signs in the signcolumn
            sign_priority = 6,
            signs = {
                add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = {
                    hl = "GitSignsChange",
                    text = "│",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = {
                    hl = "GitSignsDelete",
                    text = "‾",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                },
                changedelete = {
                    hl = "GitSignsChange",
                    text = "~",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
                untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            },
            -- Alternative sign text
            -- signs = {
            --   add = { text = '+' },
            --   change = { text = '~' },
            --   delete = { text = '_' },
            --   topdelete = { text = '‾' },
            --   changedelete = { text = '~' },
            -- },
        },
    },
}
