" =============================================================================
" VIM configuration file
" =============================================================================

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
call plug#end()

" Basic configuration
let mapleader=","
inoremap jk <ESC>
set noswapfile
set nobackup
set pastetoggle=<F2>
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set encoding=utf-8
set nocompatible
set number
set relativenumber

" Shortcuts
let mapleader=','
inoremap jk <ESC>
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':W' | :q
command WQ :Wq
nnoremap <leader>n :set nonumber!<CR>
nnoremap <leader>rn :set norelativenumber!<CR>
nnoremap <leader>c :nohl<CR>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
au FocusLost * :wa
vnoremap . :norm.<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>d :read !date<CR>
nnoremap <leader>rc :so $MYVIMRC<CR>

" Movement
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Syntax
set expandtab
autocmd FileType make set noexpandtab
autocmd FileType automake set noexpandtab
autocmd FileType fstab set noexpandtab
autocmd FileType c set noexpandtab
set shiftwidth=4
set tabstop=4
autocmd FileType c set shiftwidth=8
autocmd FileType c set tabstop=8
autocmd FileType json set shiftwidth=2
autocmd FileType json set tabstop=2

" Color and graphics
color molokai
set list
set colorcolumn=80
set numberwidth=5

" Search and replace
set smartcase
set showmatch
set hlsearch

" #############################################################################
" PLUGINS
" #############################################################################

" VIM-AIRLINE (https://github.com/bling/vim-airline)
let g:airline_powerline_fonts = 1

nmap <F8> :TagbarToggle<CR>

" Rainbow parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
