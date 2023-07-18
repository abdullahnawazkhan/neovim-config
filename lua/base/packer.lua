--Plug 'kyazdani42/nvim-web-devicons' This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'sainnhe/everforest',
        as = 'everforest',
        config = function ()
          vim.cmd('colorscheme everforest')
        end
    }

    use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }

    use 'ray-x/lsp_signature.nvim'

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
      }
    }

    use 'nvim-tree/nvim-tree.lua'
    use 'tpope/vim-commentary'
    use 'ryanoasis/vim-devicons'
    use 'vim-airline/vim-airline'
    use 'jiangmiao/auto-pairs'
    use 'klen/nvim-config-local'
    use 'romgrk/barbar.nvim'
    use 'folke/todo-comments.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'airblade/vim-gitgutter'

    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
end)
