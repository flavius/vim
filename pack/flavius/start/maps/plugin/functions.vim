function! ListBuffers()
    let lasttabnr = tabpagenr('$')
    let seen_buffers = []
    for tabnr in range(1, lasttabnr)
        let tabtitle = TabooTabTitle(tabnr)
        let buffers = tabpagebuflist(tabnr)
        let windows = tabpagewinnr(tabnr, '$')
        let layout = winlayout(tabnr)
        " echom 'tab ' . tabtitle . ' has buffers ' . string(buffers) . ' and windows ' . string(windows) . ' and layout ' . string(layout)
        echom tabtitle
        for winnr in range(1, windows)
            let winid = win_getid(winnr, tabnr)
            let cwd = getcwd(winnr, tabnr)
            let bufnr = winbufnr(winid)
            let path = expand("#" . string(bufnr) .":p")
            let start = path->stridx(cwd)
            let bufname = path
            if start == 0
                let bufname = bufname[strlen(cwd)+1:]
            endif
            " echom "  win id: " . string(winid) . " has buffer " . string(bufnr) . " = " . path . " in cwd " . cwd . ' start: ' . start . " rel: " . bufname
            echom "    " . bufnr . " " . bufname
            let seen_buffers = add(seen_buffers, bufnr)
        endfor
    endfor
    echom "==========================================="
    let remove_buffers = []
    for buf in getbufinfo()
        "let buf = remove(buf, 'variables')
        let name = has_key(buf, 'name') ? buf['name'] : ""
        let bufnr = has_key(buf, 'bufnr') ? buf['bufnr'] : -1
        let listed = has_key(buf, 'listed') ? buf['listed'] : 1
        if index(seen_buffers, bufnr) == -1 && listed
            echom "    " . bufnr . ' ' . name
            let remove_buffers = add(remove_buffers, bufnr)
        endif
    endfor
    if len(remove_buffers) > 0
        let del =  input("bdelete " . join(remove_buffers) . "[yes/NO]? ", "no")
        if del == "yes"
            execute "bdelete " . join(remove_buffers)
        endif
    endif
endfunction

function! BufferIsListed(bufnr)
    let info = getbufinfo(a:bufnr + 0)
    if !len(info)
        return v:false
    endif
    if info[0].listed == 1
        return v:true
    endif
    return v:false
endfunction

function! DeleteFromTabHistory(tabnr, bufnr)
endfunction

function! OnBufVisible(bufnr)
    if !BufferIsListed(a:bufnr + 0)
        return
    endif
    if !has_key(t:visited_bufs, a:bufnr+0)
        let t:visited_bufs[a:bufnr+0] = 0
    endif
    let t:visited_bufs[a:bufnr+0] = t:visited_bufs[a:bufnr+0] + 1
    let tabnr = tabpagenr()
    echom "buffer visible " . a:bufnr . ' tab: ' . tabnr . ' visited: ' . string(t:visited_bufs)
endfunction

function! OnBufDeleted(bufnr)
    if !BufferIsListed(a:bufnr+0)
        return
    endif
    unlet t:visited_bufs[a:bufnr+0]
    " TODO: remove from all tabs
    let tabnr = tabpagenr()
    echom "buffer deleted " . a:bufnr . ' tab: ' . tabnr . ' visited: ' . string(t:visited_bufs)
endfunction

autocmd BufEnter * call OnBufVisible(expand('<abuf>') + 0)
autocmd BufEnter * echom "BufEntered " . expand('<abuf>') . ' ' . expand('<afile>')
autocmd BufDelete * call OnBufDeleted(expand('<abuf>') + 0)


function! ListTabBuffers()
    let tabnr = tabpagenr()
    let visited_bufs = gettabvar(tabnr, 'visited_bufs', {})
    echom visited_bufs
    echom keys(visited_bufs)
    for bufnr in keys(visited_bufs)
        " if !BufferIsListed(bufnr)
        "     continue
        " endif
        let info = getbufinfo(bufnr+0)[0]
        unlet info['variables']
        let vis_count = visited_bufs[bufnr]
        echom bufnr . "      visited " . vis_count . "        " . info['name'] . "       info " . string(info)
    endfor
endfunction


function! OnTabCreated(reason)
    if !exists('t:visited_bufs')
        let t:visited_bufs = {}
    endif
    let tabnr = tabpagenr()
    echom "tab entered: " . tabnr . ' ' . a:reason
endfunction

" autocmd TabEnter * call OnTabCreated('TabEnter')
autocmd TabNew * call OnTabCreated('TabNew')
" autocmd GUIEnter * call OnTabCreated('GUIEnter')
" autocmd BufNewFile * call OnTabCreated('BufNewFile')
" autocmd BufNew * call OnTabCreated('BufNew')
autocmd BufWinEnter * call OnTabCreated('BufWinEnter')


autocmd BufHidden * echom "BufHidden " . expand('<abuf>') . ' ' . expand('<afile>')
autocmd BufLeave * echom "BufLeave " . expand('<abuf>') . ' ' . expand('<afile>')
autocmd BufWipeout * echom "BufWipeout " . expand('<abuf>') . ' ' . expand('<afile>')
