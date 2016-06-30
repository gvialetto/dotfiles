" ===============================================================================
" VIM configuration file
" ===============================================================================

set nocompatible
filetype off
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
let mapleader=","                               " Change mapleader
set noswapfile                                  " No .swp files
set nobackup                                    " No *~ files
set pastetoggle=<F2>                            " Paste mode switch
set undolevels=1000                             " LOOTS of undo levels!
set wildignore=*.swp,*.bak,*.pyc,*.class        " Files extensions to ignore
set title                                       " Change terminal title
set visualbell                                  " Don't beep
set noerrorbells                                " Again, don't beep

" Sudo save
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':W' | :q
command WQ :Wq

" I don't want to use the arrows to move around
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Syntax
set expandtab                                   " Expand tabs to spaces
autocmd FileType make set noexpandtab           " ...but not in make
autocmd FileType automake set noexpandtab       " ...and not automake
autocmd FileType fstab set noexpandtab          " ...and not fstab
autocmd FileType c set noexpandtab
set shiftwidth=4
set tabstop=4
autocmd FileType c set shiftwidth=8
autocmd FileType c set tabstop=8

" Color and graphics
color molokai                                   " Color theme
set list                                        " Display whitespaces

" Search and replace
set smartcase                                   " Ignore case if pattern is lowercase
set showmatch                                   " Show search results matches
set hlsearch                                    " Highlight search results

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

