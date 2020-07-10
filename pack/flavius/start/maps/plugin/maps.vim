let mapleader=','
let maplocaleader='\\'

nnoremap <leader>cd :tcd %:p:h<CR>

nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>

nnoremap <Leader>ev :edit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <silent> <Leader>tn :TabHistoryGotoNext<CR>
nnoremap <silent> <Leader>tp :TabHistoryGotoPrev<CR>
nnoremap <silent> <Leader>tc :TabHistoryClear<CR>
nnoremap <silent> <Leader>tl :TabHistoryList<CR>
