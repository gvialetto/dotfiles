" GUI
set guioptions-=m           " Remove menu bar
set guioptions-=T           " Remove toolbar
set guioptions-=r           " Remove right-hand scroll bar
set mousehide
set mouse=a

" Call back GUI as needed
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

" Theme
set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
colorscheme molokai

