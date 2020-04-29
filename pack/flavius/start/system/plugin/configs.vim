function! EnsureDirectory(d)
    if !isdirectory(a:d)
        call mkdir(a:d, "p")
    endif
endfunction

call EnsureDirectory(g:VIMDIR . "/tmp/backup")
call EnsureDirectory(g:VIMDIR . "/tmp/swap")
call EnsureDirectory(g:VIMDIR . "/tmp/view")
call EnsureDirectory(g:VIMDIR . "/tmp/undo")
call EnsureDirectory(g:VIMDIR . "/tmp/tags")

silent execute 'set backupdir=' . g:VIMDIR . '/tmp/backup/'
set backup
silent execute 'set directory=' . g:VIMDIR . '/tmp/swap/'
silent execute 'set viewdir=' . g:VIMDIR . '/tmp/view/'
silent execute 'set undodir=' . g:VIMDIR . '/tmp/undo/'
set undofile
silent execute "set viminfo='50,!,n" . g:VIMDIR . "/tmp/viminfo"
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,winpos,resize,globals

silent execute 'let g:netrw_home="' . g:VIMDIR . '/tmp/"'

let $PATH .= '~/bin'
