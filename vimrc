set nocompatible
set mouse=n

" Appearance options
set nu rnu
syntax on
colo moonshine
set ruler
set display=uhex

" Tabbing options
set ts=4
set sw=4
set noexpandtab
set autoindent
set smarttab
set sr

set showmatch
set matchtime=1

" Backslashes in regexes less necessary
set magic

" Swap file location
set dir=$HOME/.vim/swap

" Undo history
set undofile
set undodir=$HOME/.vim/undo

set tags=./tags;

filetype plugin indent on
au FileType * setlocal comments-=:// comments+=f://
au BufNewFile,BufRead *.asm setf nasm
au BufNewFile,BufRead *.inc setf nasm
au BufNewFile,BufRead *.jsm setf javascript

au BufReadCmd *.jar,*.bundle call zip#Browse(expand("<amatch>"))

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

let mapleader = "-"

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <Leader>c :set cuc!<Cr>
nnoremap <Leader>l :set cul!<Cr>
nnoremap <Leader>s :set hls!<Cr>
nnoremap <Leader>o :tabp<Cr>
nnoremap <Leader>o :tabn<Cr>

command! Ev vs $MYVIMRC
command! Sv so $MYVIMRC
command! Elv vs $HOME/.rcola/local/vimrc
command! Slv so $HOME/.rcola/local/vimrc
command! DiscardUndos set undoreload=0 | edit | set undoreload=10000

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

execute pathogen#infect()

" DetectIndent plugin settings
au BufReadPost * :DetectIndent
let g:detectindent_preferred_expandtab = 0
let g:detectindent_preferred_indent = 4

" Load local overrides/settings
source $HOME/.rcola/local/vimrc
