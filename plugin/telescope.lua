require('telescope').setup{
  defaults = {
    file_ignore_patterns={'node_modules', '.git/', 'sequelize/'},
    mappings = {
      n = {
          ["<S-CR>"] = "select_tab"
      }
    }
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files hidden=true<cr>', {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
