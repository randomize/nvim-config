return {
    -- "gc" to comment visual regions/lines
    -- {
    --   "echasnovski/mini.comment",
    --   event = "VeryLazy",
    --   opts = {
    --     hooks = {
    --       pre = function()
    --         require("ts_context_commentstring.internal").update_commentstring({})
    --       end,
    --     },
    --   },
    --   config = function(_, opts)
    --     require("mini.comment").setup(opts)
    --   end,
    -- },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                init = function()
                    vim.g.skip_ts_context_commentstring_module = true
                end,
                config = function()
                    require("randy.ts_context_commentstring_compat").setup()
                    require("ts_context_commentstring").setup({
                        enable_autocmd = false,
                    })
                end,
            },
        },
        lazy = false,
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
}
