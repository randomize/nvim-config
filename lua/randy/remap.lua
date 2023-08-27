
vim.keymap.set("n", "<space>q", "<cmd>q<CR>", { silent = true, desc = 'Quit'})
vim.keymap.set("n", "<space>Q", "<cmd>qa!<CR>", { silent = true, desc = 'Force Quit'})
vim.keymap.set("n", "<space>w", "<cmd>w<CR>", { silent = true, desc = 'Write'})
vim.keymap.set("n", "<space>W", "<cmd>wa<CR>", { silent = true, desc = 'Write All'})

vim.keymap.set("n", "<space>]", ":bn<CR>")
vim.keymap.set("n", "<space>[", ":bp<CR>")
vim.keymap.set("n", "<space>c", ":bd<CR>")
vim.keymap.set("n", "<space>(", ":lne<CR>")
vim.keymap.set("n", "<space>)", ":lp<CR>")
vim.keymap.set({ "n", "v" }, "<space>y", [["+y]])
vim.keymap.set("n", "<space>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<space>d", [["_d]])
vim.keymap.set("x", "<space>P", [["_dP]])

vim.keymap.set("n", "<tab>", "<c-^>", { silent = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", ",s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", ",x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", ",w", "<cmd>set wrap!<CR>")

-- Switch to the directory of the open buffer
vim.keymap.set('n', ',cd', '<cmd>lcd %:p:h<CR>:pwd<CR>')
vim.keymap.set('n', ',ev', '<cmd>vsplit $MYVIMRC<CR>',{noremap = true})

-- Folds
-- Mappings to easily toggle fold levels
vim.keymap.set("n", "z0", "<cmd>set foldlevel=0<cr>")
vim.keymap.set("n", "z1", "<cmd>set foldlevel=1<cr>")
vim.keymap.set("n", "z2", "<cmd>set foldlevel=2<cr>")
vim.keymap.set("n", "z3", "<cmd>set foldlevel=3<cr>")
vim.keymap.set("n", "z4", "<cmd>set foldlevel=4<cr>")
vim.keymap.set("n", "z5", "<cmd>set foldlevel=5<cr>")

