require('telescope').setup{
  extensions = {
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
      no_ignore = true,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
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
require("telescope").load_extension "file_browser"

vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>p', '<cmd>Telescope file_browser<cr>', {})
