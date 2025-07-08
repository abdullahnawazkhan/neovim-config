local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  {
    'sainnhe/everforest',
    name = 'everforest', -- optional alias
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme everforest')
    end
  },
   {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  "ray-x/lsp_signature.nvim",
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        '',
        '',
        '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡎⢧',
        '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣵⣶⣾⡶⠶⠿⠿⠶⠿⠾⠶⠶⠼⢮⣙⠢⠤⣀⡀',
        '⣿⣿⣿⣿⣿⣿⣟⣿⣽⣵⣶⠾⠿⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠓⡲⣦⣀',
        '⣿⣛⣯⣭⣵⡿⠿⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠽⡇',
        '⡿⠿⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠁',
        '⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢀⣰⣿⡿⠀⠀⠀⠀⣠⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠖⠉',
        '⣰⣀⣼⣿⣇⢰⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⣀⣠⣾⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⠖⠉',
        '⣿⡿⢻⠟⠿⠈⠀⠀⠀⠀⣠⣴⣦⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⢸⡇',
        '⠉⠁⠀⠀⠀⠀⠀⠀⠀⠰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠄⠀⠀⠀⠀⠀⢸⡇',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠌⠁⠀⠀⠀⠀⠀⠀⠀⢸⡇',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⡘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢿⣦⣽⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠻⣿⣿⣿⣿⣿⣷⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⢠⡞',
        '⠀⠀⠀⠀⠀⠀⠀⠀⣤⡀⢙⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⢀⣤⠶⠖⠉',
        '⠀⢀⣰⣦⣭⣿⣷⣤⣔⣣⠀⠱⣗⢬⠙⠻⢿⣿⣿⣿⣿⣿⡟⠁⢰⠏⠉',
        '⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡀⠈⠡⠐⣠⡶⠦⣭⣙⣛⣉⣠⡴⠏',
        '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⡏⠀⠀⠀⠈⠉⠉⠉',
      }

      alpha.setup(dashboard.opts)
    end,
  },
   {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
   'tpope/vim-commentary',
   'ryanoasis/vim-devicons',
   'vim-airline/vim-airline',
   'jiangmiao/auto-pairs',
   'klen/nvim-config-local',
   'kyazdani42/nvim-web-devicons',
   'airblade/vim-gitgutter',
   'f-person/git-blame.nvim',
   {
     'nvim-treesitter/nvim-treesitter',
     lazy=false,
      build = ':TSUpdate'
   },
  --  ('github/copilot.vim')
   'mfussenegger/nvim-dap',
   { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
   {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}, {
  rocks = {
    enabled = false,
  }
})

