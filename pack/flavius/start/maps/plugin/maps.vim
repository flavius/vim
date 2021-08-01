let mapleader=','
let maplocaleader='\\'

nnoremap <leader>cd :tcd %:p:h<CR>

nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>

nnoremap <Leader>ev :edit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>


nnoremap <silent> <Leader>tn :TabHistoryGotoNext<CR>
nnoremap <silent> <Leader>tp :TabHistoryGotoPrev<CR>
nnoremap <silent> <Leader>tc :TabHistoryClear<CR>
nnoremap <silent> <Leader>tl :TabHistoryList<CR>
nnoremap <silent> <Leader>e :e ++enc=latin1<CR>

nnoremap Y y$

" keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" insert break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ; ;<c-g>u
inoremap + +<c-g>u
inoremap - -<c-g>u
inoremap * *<c-g>u
inoremap / /<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap = =<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap " "<c-g>u
inoremap ' '<c-g>u

" jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" moving text
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

function a
endfunction
