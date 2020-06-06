if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Utilities
Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
" Color themes
Plug 'joshdick/onedark.vim'
" Programming general
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"----------------------------------------------------------------------------
" TagBar
"----------------------------------------------------------------------------
nmap <leader>t :TagbarToggle<CR>
nmap <F8> :TagbarToggle<CR>

"----------------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------------
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
let NERDTreeWinSize = 35

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree 

" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" Toogle on/off
nmap <leader>o :NERDTreeToggle<cr>
nmap <F7> :NERDTreeToggle<CR>

"----------------------------------------------------------------------------
" RainbowParentheses
"----------------------------------------------------------------------------
au VimEnter * :RainbowParentheses

"----------------------------------------------------------------------------
" Lightline
"----------------------------------------------------------------------------
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'git', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'git': 'fugitive#head'
      \ },
    \ }
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ [] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
