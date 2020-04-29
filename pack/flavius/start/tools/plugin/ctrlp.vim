nnoremap <silent> <C-S> :CtrlPBuffer<CR>
nnoremap <silent> <C-m> :CtrlPMRU<CR>
nnoremap <silent> <C-7> :CtrlPTag<CR>

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|Cargo.lock'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_working_path_mode = 'd'

" ctrlp
let g:ctrlp_cache_dir = s:root . '/tmp/ctrlp-cache'
