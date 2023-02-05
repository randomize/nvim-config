return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		config = true,
		opts = {
			select = {
				builtin = {
					-- These are passed to nvim_open_win
					anchor = "NW",
					border = "single",
				},
			},
		},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}
