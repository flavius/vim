packadd! vim-airline
packadd! vim-airline-themes
let g:airline_theme='dark' " simple, luna,
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_detect_paste=1
let g:airline_powerline_fonts = 1
let g:airline_filetype_overrides = {
  \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
  \ 'gundo': [ 'Gundo', '' ],
  \ 'help':  [ 'Help', '%f' ],
  \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
  \ 'startify': [ 'startify', '' ],
  \ 'vim-plug': [ 'Plugins', '' ],
  \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
  \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
  \ }
let g:airline_exclude_preview = 0
