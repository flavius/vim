" Go to the next-higher buffer number
function! TabHistoryNext()
    let visited_bufs = GetSortedBuffersOfTab(tabpagenr())
    let current_buf = str2nr(bufnr())
    let current_pos = index(visited_bufs, current_buf)
    if current_pos == -1
        echom "Current buffer not found"
        return
    endif
    if current_pos == len(visited_bufs)-1
        let new_buffer_pos = 0
    else
        let new_buffer_pos = current_pos + 1
    endif
    " echo "sorted " . string(visited_bufs) . " current " . string(current_buf) . " index " . current_pos . " new buffer pos " . new_buffer_pos
    execute "buffer" visited_bufs[new_buffer_pos]
endfunction

" Go to the previous buffer by number
function! TabHistoryPrev()
    let visited_bufs = GetSortedBuffersOfTab(tabpagenr())
    let current_buf = str2nr(bufnr())
    let current_pos = index(visited_bufs, string(current_buf))
    if current_pos == -1
        return
    endif
    if current_pos == 0
        let new_buffer_pos = len(visited_bufs)-1
    else
        let new_buffer_pos = current_pos - 1
    endif
    execute "buffer" visited_bufs[new_buffer_pos]
endfunction

" Reset the histogram. The list of buffers is kept, but the visit count is
" reset to 0, except for the current buffer, which is set to 1.
function! TabHistoryReset()
endfunction

" List buffers visited by this tab and some additional information
function! TabHistoryList()
    let tabnr = tabpagenr()
    let visited_bufs = gettabvar(tabnr, 'visited_bufs', {})
    echom visited_bufs
    echom keys(visited_bufs)
    for bufnr in keys(visited_bufs)
        " if !BufferIsListed(bufnr)
        "     continue
        " endif
        let info = getbufinfo(bufnr+0)[0]
        if has_key(info, 'variables')
            unlet info['variables']
        endif
        if has_key(info, 'signs')
            unlet info['signs']
        endif
        let vis_count = visited_bufs[bufnr]
        echom bufnr . "      visited " . vis_count . "        " . info['name'] . "       info " . string(info)
    endfor
endfunction

" Remove all buffers from the history, making it look like the current tab has
" never seen any (listed) buffers. Your TabHistory key bindings will not work
" until you start navigating buffers in the current tab by other means, thus
" refilling the history with fresh data.
function! TabHistoryClear()
endfunction

" Navigate to one of the buffers which was visited more than the current buffer
function! TabHistoryUp()
endfunction


" Navigate to one of the buffers which was visited less than the current buffer
function! TabHistoryDown()
endfunction


function! GetSortedBuffersOfTab(tabnr)
    let visited_bufs = gettabvar(a:tabnr, 'visited_bufs', {})
    let visited_bufs = keys(visited_bufs)
    let t = map(visited_bufs, {k, v -> str2nr(v) })
    return sort(t)
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
    let visited_bufs = gettabvar(a:tabnr, 'visited_bufs', {})
    if has_key(visited_bufs, a:bufnr)
        unlet visited_bufs[a:bufnr]
        call settabvar(a:tabnr, 'visited_bufs', visited_bufs)
    endif
endfunction

function! DeleteFromAllTabHistory(bufnr)
    for tabnr in range(1, tabpagenr('$'))
        call DeleteFromTabHistory(tabnr, a:bufnr)
    endfor
endfunction!

function! OnBufVisible(bufnr)
    if !BufferIsListed(a:bufnr + 0)
        return
    endif
    if !has_key(t:visited_bufs, a:bufnr+0)
        let t:visited_bufs[a:bufnr+0] = 0
    endif
    let t:visited_bufs[a:bufnr+0] = t:visited_bufs[a:bufnr+0] + 1
    let info = getbufinfo(a:bufnr+0)[0]
    unlet info['variables']
    let tabnr = tabpagenr()
    let name = fnamemodify(info['name'], ':t')
    " echom "buffer visible " . a:bufnr . ' tab: ' . tabnr . ' visited: ' . string(t:visited_bufs) . ' info: ' . string(info) . ' name ' . name
endfunction

function! OnBufDeleted(bufnr)
    if !BufferIsListed(a:bufnr+0)
        return
    endif
    call DeleteFromAllTabHistory(a:bufnr)
    let tabnr = tabpagenr()
    " echom "buffer deleted " . a:bufnr . ' tab: ' . tabnr . ' visited: ' . string(t:visited_bufs)
endfunction

function! FilterFileTypes(bufnr)
    let ft = getbufvar(a:bufnr, '&filetype')
    " echom "filetype detected: " . ft . " in buf " . a:bufnr
    if (index([], ft) >= 0)
        call DeleteFromAllTabHistory(a:bufnr)
    endif
    if !BufferIsListed(a:bufnr + 0)
        call DeleteFromAllTabHistory(a:bufnr)
    endif
endfunction

autocmd BufEnter * call OnBufVisible(expand('<abuf>') + 0)
autocmd BufDelete * call OnBufDeleted(expand('<abuf>') + 0)
autocmd BufWipeout * call OnBufDeleted(expand('<abuf>') + 0)
autocmd FileType * call FilterFileTypes(expand('<abuf>') + 0)



function! OnTabCreated(reason)
    if !exists('t:visited_bufs')
        let t:visited_bufs = {}
    endif
    let tabnr = tabpagenr()
    " echom "tab entered: " . tabnr . ' ' . a:reason
endfunction

" autocmd TabEnter * call OnTabCreated('TabEnter')
autocmd TabNew * call OnTabCreated('TabNew')
autocmd BufWinEnter * call OnTabCreated('BufWinEnter')
autocmd FileType * call OnTabCreated('FileType')

