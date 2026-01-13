local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- THEMES & UI
  { 'sainnhe/everforest', lazy = false, priority = 1000, config = function() vim.cmd.colorscheme 'everforest' end },
  { 'goolord/alpha-nvim', event = 'VimEnter', config = function() require'alpha'.setup(require'alpha.themes.dashboard'.opts) end },
  'vim-airline/vim-airline',
  'ryanoasis/vim-devicons',
  'kyazdani42/nvim-web-devicons',

  -- THE ENGINE (Treesitter v1.0.0+ Fix)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html", "css", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then configs.setup(opts) end
    end
  },

  -- LSP & AUTOCOMPLETE (v3.x Fix)
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'ray-x/lsp_signature.nvim',
    },
  },

  -- COPILOT CHAT
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      -- model = "claude-4.5-sonnet", -- SETS DEFAULT TO CLAUDE
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      -- Optional: Ensure it always uses the same window style
      window = {
        layout = 'vertical',
        width = 0.4,
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
      -- Add the "Model Switcher" keymap here for quick manual swaps
      { "<leader>cm", "<cmd>CopilotChatModels<CR>", desc = "Switch AI Model" },
    },
  },

  -- TOOLS & UTILITIES
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'nvim-telescope/telescope-file-browser.nvim',
  'tpope/vim-commentary',
  'jiangmiao/auto-pairs',
  'airblade/vim-gitgutter',
  'f-person/git-blame.nvim',
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  'klen/nvim-config-local',
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        fps = 60,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        render = "default",
        stages = "fade_in_slide_out", -- "fade", "slide", or "fade_in_slide_out"
        timeout = 3000,
        top_down = false, -- Put it in the bottom right
      })
      -- This makes Neovim use this plugin for all messages
      vim.notify = require("notify")
    end
  }
}, { rocks = { enabled = false } })
