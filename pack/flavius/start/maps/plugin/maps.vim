let mapleader=','
let maplocaleader='\\'

nnoremap <leader>cd :tcd %:p:h<CR>

nnoremap <leader>ew :e <C-R>=expand("%:.:h") . "/"<CR>

nnoremap <Leader>ev :edit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <Leader>bn :call TabHistoryNext()
nnoremap <Leader>bp :call TabHistoryPrev()
nnoremap <Leader>bl :call TabHistoryList()
