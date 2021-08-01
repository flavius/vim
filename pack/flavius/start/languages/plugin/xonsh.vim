autocmd BufRead,BufNewFile *.xsh call StartXonsh()

function! StartXonsh()
    packadd! xonsh-vim
    setlocal filetype=xonsh
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal textwidth=79
    setlocal expandtab
    setlocal autoindent
    setlocal fileformat=unix
endfunction
