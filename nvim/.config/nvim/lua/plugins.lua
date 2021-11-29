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

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }

  use {
    'ggandor/lightspeed.nvim',
    requires = {'tpope/vim-repeat', opt = true}
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release',
  }

  use "lukas-reineke/indent-blankline.nvim"

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('lualine').setup()
require('gitsigns').setup()

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
require("indent_blankline").setup {
  space_char_blankline = " ",
}
