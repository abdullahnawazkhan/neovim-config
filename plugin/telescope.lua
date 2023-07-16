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

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
