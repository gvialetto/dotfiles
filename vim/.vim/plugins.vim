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
Plug 'mengelbrecht/lightline-bufferline'
Plug 'wincent/terminus'
Plug 'ntpeters/vim-better-whitespace'
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
" Autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | execute 'NERDTree' | endif
" Close VIM if nerdtree is the only buffer left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" Toogle on/off + open on the right position

" Stolen from https://www.reddit.com/r/vim/comments/g47z4f/synchronizing_nerdtree_with_the_currently_opened/
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

nnoremap <silent> <leader>o :NERDTreeToggle<cr><c-w>l:call SyncTree()<cr><c-w>h
nnoremap <silent> <F7> :NERDTreeToggle<CR><c-w>l:call SyncTree()<cr><c-w>h

" Hack to not show lightline in NerdTree
" Stolen from (with minor changes) https://stackoverflow.com/questions/36864377/open-nerdtree-automatically-when-start-vim-on-a-folder-and-dont-show-two-tree-v
augroup filetype_nerdtree
    au!
    au FileType nerdtree setlocal nonumber norelativenumber
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

function s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    " TODO: this should prevent flickering, but works only in vim. Check why.
    if nerdtree_winnr && !has("nvim")
        exe 'au SafeState * ++once call setwinvar('..nerdtree_winnr..', "&stl", "%#Normal#")'
    else
        call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
    endif
endfunction

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
      \ 'tabline' : {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
    \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number = 2
nmap <leader>1 <Plug>lightline#bufferline#go(1)
nmap <leader>2 <Plug>lightline#bufferline#go(2)
nmap <leader>3 <Plug>lightline#bufferline#go(3)
nmap <leader>4 <Plug>lightline#bufferline#go(4)
nmap <leader>5 <Plug>lightline#bufferline#go(5)
nmap <leader>6 <Plug>lightline#bufferline#go(6)
nmap <leader>7 <Plug>lightline#bufferline#go(7)
nmap <leader>8 <Plug>lightline#bufferline#go(8)
nmap <leader>9 <Plug>lightline#bufferline#go(9)
nmap <leader>0 <Plug>lightline#bufferline#go(10)

"----------------------------------------------------------------------------
" Deoplete
"----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
" vim-go uses omnicomplete, let's use that in deoplete for go files
set completeopt+=noselect
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
" Automatically close scratch window with definitions
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" TAB, TAB everywhere
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
