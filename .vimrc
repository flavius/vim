set nocompatible
scriptencoding utf-8
set termencoding=utf-8
set encoding=utf-8
set shell=/bin/zsh
let g:VIMDIR = fnamemodify(resolve(expand('<sfile>:p')), ':h')
set runtimepath-=~/.vim runtimepath-=~/.vim/after runtimepath-=~/vimfiles runtimepath-=~/vimfiles/after
set packpath-=~/.vim packpath-=~/.vim/after packpath-=~/vimfiles packpath-=~/vimfiles/after
silent execute 'set runtimepath^=' . g:VIMDIR
silent execute 'set packpath^=' . g:VIMDIR

let mapleader=','
let maplocaleader='\\'
let $MYVIMRC=g:VIMDIR . '/.vimrc'

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

