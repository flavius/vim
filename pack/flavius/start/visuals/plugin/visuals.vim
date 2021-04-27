set updatetime=100
set visualbell
set title
set relativenumber
set number
set modeline
set showmode
set showcmd
set showmatch
set incsearch
set hlsearch
set wildmenu
set wildmode=list:longest,full
if has('multi_byte')
    set list
    if $TERM == "linux"
        set nolist
    endif
endif
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«
"set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:⌴
" set fillchars=diff:⣿,vert:\│,fold:—
set fillchars=diff:⣿,vert:\ ,fold:—
" set fillchars=diff:⣿,vert:\ﮋ,fold:—
set showbreak=↪
set ttyfast
set lazyredraw
set ruler
set textwidth=79
set wrapmargin=80
set formatoptions=qrn1
set colorcolumn=80
set splitright splitbelow
set laststatus=2
set shortmess+=afilmnrxoOtT
set cursorline
set viewoptions=folds,options,cursor,unix,slash
set viewoptions-=options " avoid problems with cwd"
" Terminal timeout {
    set notimeout
    set ttimeout
    set ttimeoutlen=10
" }
" Coloring {
    packadd! dracula
    colorscheme dracula
    " highlight Folded term=standout ctermfg=0 ctermbg=7 guifg=Black guibg=ivory3
    highlight WhitespaceEOL ctermbg=Red guibg=Red
    match WhitespaceEOL /\s\+$/
" }
" Diff {
    set diffopt+=iwhite,vertical
" }
" GUI {
    if has('gui_running')
        set guifont=DroidSansMono\ Nerd\ Font\ 10
        set guioptions-=T " no toolbars
        set guioptions+=LlRrb guioptions-=LlRrb " no scrollbars
    endif
" }
" Cursor {
    autocmd VimLeave * silent !echo -ne "\033]112\007"
"    let &t_SI = "\<Esc>]12;green\x7\<Esc>[5 q" " cursor color in insert mode
"    let &t_EI = "\<Esc>]12;white\x7"   " cursor color in normal mode
" }

syntax on
filetype plugin indent on
set foldmethod=syntax
set splitbelow splitright
set scrolloff=3
