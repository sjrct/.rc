set nocompatible
set mouse=n

" Appearance options
set nu rnu
syntax on
colo delek
set ruler
set display=uhex

" Tabbing options
set ts=2
set sw=2
set expandtab
set autoindent
set smarttab
set sr

set showmatch
set matchtime=1

" Swap file location
set dir=$HOME/.vim/swap

" Undo history
set undofile
set undodir=$HOME/.vim/undo

filetype plugin indent on
au FileType * setlocal comments-=:// comments+=f://
au BufNewFile,BufRead *.asm setf nasm
au BufNewFile,BufRead *.inc setf nasm

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" TODO associate with filetype .js
iab fnc function
iab cnl console.log
iab cni console.info
iab cne console.error
iab cnw console.warn

let mapleader = "-"

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <Leader>c :set cuc!<Cr>
nnoremap <Leader>s :set hls!<Cr>

command! Ev vs $MYVIMRC
command! Sv so $MYVIMRC
command! Elv vs $HOME/.rcola/local/vimrc
command! Slv so $HOME/.rcola/local/vimrc
command! DiscardUndos set undoreload=0 | edit | set undoreload=10000

execute pathogen#infect()

" Load local overrides/settings
source $HOME/.rcola/local/vimrc
