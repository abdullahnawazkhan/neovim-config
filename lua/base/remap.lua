vim.g.mapleader = " "

vim.keymap.set('n', '<leader>w', '<Cmd>close<CR>')
vim.keymap.set('n', '<leader>v', '<Cmd>vnew<CR>')

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy relative file path to clipboard' })

