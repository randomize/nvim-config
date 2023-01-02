local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>uf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ug', builtin.git_files, {})
vim.keymap.set('n', '<leader>us',  function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });

end)
