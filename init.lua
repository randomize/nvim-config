require('randy')

-- require('json_linter')

-- Keymap to manually lint
-- vim.api.nvim_set_keymap('n', '<leader>jl', ':lua require("json_linter").lint_json_paths()<CR>', { noremap = true, silent = true })
--
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
--     pattern = "*.json",
--     callback = function()
--         require('json_linter').lint_json_paths()
--         require('json_linter').highlight_invalid_paths()
--     end
-- })
