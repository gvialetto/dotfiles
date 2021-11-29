lua require('plugins')

let g:tokyonight_style = "night"
colorscheme tokyonight

" ------------------------------------------------------------------------------
" Basic configuration
" ------------------------------------------------------------------------------
set noswapfile
set nobackup
set nowritebackup
set pastetoggle=<F2>
set wildignore=*.o,*~,*.swp,*.bak,*.pyc,*.class
set wildignore+=*/.git/*,*/.hg/*,*/tmp/*,*.tmp
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
set title
set noshowmode
set visualbell
set noerrorbells
set hid
au FocusGained,BufEnter * checktime
set whichwrap+=<,>,h,l
set lazyredraw
set nowrap

" ------------------------------------------------------------------------------
" Gutter
" ------------------------------------------------------------------------------
set number
set relativenumber
set numberwidth=5

" ------------------------------------------------------------------------------
" Shortcuts
" ------------------------------------------------------------------------------
let mapleader=','
nnoremap <leader>w :w!<cr>
nnoremap <leader>rc :so $MYVIMRC<CR>
map <silent> <leader><cr> :noh<cr>
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':W' | :q
command WQ :Wq
" Better movement around windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l


" ------------------------------------------------------------------------------
" Filetypes configuration
" ------------------------------------------------------------------------------
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4

autocmd FileType make set noexpandtab
autocmd FileType automake set noexpandtab
autocmd FileType fstab set noexpandtab
autocmd FileType c set noexpandtab

autocmd FileType c set shiftwidth=8
autocmd FileType c set tabstop=8
autocmd FileType json set shiftwidth=2
autocmd FileType json set tabstop=2
autocmd FileType lua set tabstop=2
autocmd FileType lua set shiftwidth=2
