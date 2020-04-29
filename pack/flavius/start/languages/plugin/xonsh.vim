autocmd BufRead,BufNewFile *.xsh call StartXonsh()

function! StartXonsh()
    packadd! xonsh-vim
    setlocal filetype=xonsh
endfunction
