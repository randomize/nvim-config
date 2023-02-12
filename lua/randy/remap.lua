vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<space>q", ":q<CR>")
vim.keymap.set("n", "<space>Q", ":qa!<CR>")
vim.keymap.set("n", "<space>w", ":w<CR>")
vim.keymap.set("n", "<space>W", ":wa<CR>")

--vim.keymap.set("n", "<space>", "<NOP>")
vim.keymap.set("n", "<space>w", ":w<CR>")
vim.keymap.set("n", "<space>q", ":q<CR>")
vim.keymap.set("n", "<space>]", ":bn<CR>")
vim.keymap.set("n", "<space>[", ":bp<CR>")
vim.keymap.set("n", "<space>c", ":bd<CR>")
-- vim.keymap.set("n", "<space>d", ":bp\\|bd #<CR>")
vim.keymap.set("n", "<space>(", ":lne<CR>")
vim.keymap.set("n", "<space>)", ":lp<CR>")

-- When entering command, press %% to quickly insert current path
vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<CR> ", { silent = true })

vim.keymap.set("n", "<tab>", "<c-^>", { silent = true })

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>")


-- Folds
-- Mappings to easily toggle fold levels
vim.keymap.set("n", "z0", "<cmd>set foldlevel=0<cr>")
vim.keymap.set("n", "z1", "<cmd>set foldlevel=1<cr>")
vim.keymap.set("n", "z2", "<cmd>set foldlevel=2<cr>")
vim.keymap.set("n", "z3", "<cmd>set foldlevel=3<cr>")
vim.keymap.set("n", "z4", "<cmd>set foldlevel=4<cr>")
vim.keymap.set("n", "z5", "<cmd>set foldlevel=5<cr>")

