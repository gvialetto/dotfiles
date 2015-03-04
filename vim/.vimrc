" ===============================================================================
" VIM configuration file
" ===============================================================================

" Initialize vundle
set nocompatible
filetype off
set rtp+=~/.local/vim/bundle/Vundle.vim
call vundle#begin('~/.local/vim/bundle')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" other plugins
Plugin 'tomasr/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-clojure-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Basic configuration
set showcmd
let mapleader=","                               " Change mapleader
inoremap ii <Esc>
vnoremap ii <Esc>
set backspace=indent,eol,start                  " Backspace over everything
set noswapfile                                  " No .swp files
set nobackup                                    " No *~ files
set pastetoggle=<F2>                            " Paste mode switch
set history=1000                                " LOOTS of history
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

" Easy edit&reload of .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Syntax
syntax on
filetype on
filetype plugin indent on
set expandtab                                   " Expand tabs to spaces
autocmd FileType make set noexpandtab           " ...but not in make
autocmd FileType automake set noexpandtab       " ...and not automake
autocmd FileType fstab set noexpandtab          " ...and not fstab
set shiftwidth=4
set tabstop=4

" Color and graphics
set ruler                                       " Show cursor position
set list                                        " Display whitespaces
set listchars=tab:>-,trail:.,extends:#          " How to display whitespaces
color molokai                                   " Color theme 
set nowrap                                      " Don't wrap lines

" Search and replace
set smartcase                                   " Ignore case if pattern is lowercase
set showmatch                                   " Show search results matches
set hlsearch                                    " Highlight search results
set incsearch                                   " Incremental search
" clear highlight for search
nmap <silent> <leader>/ :nohlsearch<CR>


" Status line (use vim-airline below if possible...)
set laststatus=2

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

