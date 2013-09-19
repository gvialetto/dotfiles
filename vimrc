" ===============================================================================
" VIM configuration file
" ===============================================================================

" Basic configuration
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
set nocompatible                                " Disable VI compatibility
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
