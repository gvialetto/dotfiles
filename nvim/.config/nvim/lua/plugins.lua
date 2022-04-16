local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', 
    install_path
  })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'folke/tokyonight.nvim'
  -- Additional filetypes
  use 'fladson/vim-kitty'

  -- Navigation
  use {
    'ggandor/lightspeed.nvim',
    requires = {'tpope/vim-repeat', opt = true}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- UI 
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() 
      require('lualine').setup {
        extensions = {'nvim-tree'},
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release',
    config = function() require('gitsigns').setup() end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append("space:⋅")
      require("indent_blankline").setup {
        space_char_blankline = " ",
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            quit_on_open = true,
          }
        }
      }
      vim.cmd [[
        augroup nvimtree_no_file
          autocmd!
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | execute 'NvimTreeOpen' | endif
        augroup end
      ]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
