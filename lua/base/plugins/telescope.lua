local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup{
  defaults = { 
    -- If you want hidden files in normal search (<leader>f)
    hidden = false,
    file_ignore_patterns = {'node_modules', '.git/'} 
  },
  extensions = { 
    file_browser = { 
      hijack_netrw = true,
      -- Property 1: Shows dotfiles (.eslintrc, .env, etc.)
      hidden = false,
      -- Property 2: Shows files even if they are in .gitignore
      no_ignore = true,
    } 
  }
}

telescope.load_extension "file_browser"

vim.keymap.set('n', '<leader>f', function()
  pcall(vim.cmd, "CopilotChatStop") 
  builtin.find_files({
    hidden = false,
    no_ignore = true
  })
end)

vim.keymap.set('n', '<leader>g', function()
  pcall(vim.cmd, "CopilotChatStop")
  builtin.live_grep()
end)

-- Added path logic so it opens where your current file is
-- vim.keymap.set('n', '<leader>p', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
vim.keymap.set(
  'n',
  '<leader>p',
  function()
    require('telescope').extensions.file_browser.file_browser({
      path = vim.fn.getcwd(),
      select_buffer = true,
    })
  end
)
