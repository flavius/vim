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

