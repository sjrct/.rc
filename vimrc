set nocompatible
execute pathogen#infect()

" Appearance options
set nu rnu
syntax on
colo moonshine
set ruler
set display=uhex

" Tabbing options
set ts=4 sw=4
set noexpandtab
set autoindent
set smarttab
set sr

set showmatch matchtime=1   " Jump quickly back to matching parens et al
set magic                   " Backslashes in regexes less necessary
set ignorecase smartcase    " Smart casing for search
set dir=$HOME/.vim/swap     " Swap file location
set mouse=n                 " Mouse enabled in normal mode
set keywordprg=:help        " K uses :help
set grepprg=ag              " Use the silver searcher for :grep

" Undo history
set undofile
set undodir=$HOME/.vim/undo

set tags=./tags;

filetype plugin indent on
au FileType * setlocal comments-=:// comments+=f://

" Languages for some filetypes
au BufNewFile,BufRead *.asm setf nasm
au BufNewFile,BufRead *.inc setf nasm
au BufNewFile,BufRead *.jsm setf javascript

" Browse jars and bundles as zip files
au BufReadCmd *.jar,*.bundle call zip#Browse(expand("<amatch>"))

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Prefix for custom shortcuts
let mapleader = "-"

" Ignore arrow keys
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" Custom shortcuts
nnoremap <Leader>c :set cuc!<Cr>
nnoremap <Leader>l :set cul!<Cr>
nnoremap <Leader>s :set hls!<Cr>
nnoremap <Leader>o :tabp<Cr>
nnoremap <Leader>p :tabn<Cr>
nnoremap <Leader>w :tabc<Cr>
nnoremap <Leader>e :tabe<Cr>
nnoremap <Leader>/ :Grep 
nnoremap <Leader>? :Grep <cword>

" Git commands
nnoremap <Leader>gb :Gblame<Cr>

" Custom commands
command! Ev e $MYVIMRC
command! Sv so $MYVIMRC
command! Elv e $HOME/.rcola/local/vimrc
command! Slv so $HOME/.rcola/local/vimrc
command! DiscardUndos set undoreload=0 | edit | set undoreload=10000
command! -nargs=+ -complete=function Grep grep! <args> | copen
command! -nargs=+ Help tab :help <args>

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

" Ignore these files in wildcard, autocomplete, ctrl-p, etc
set wildignore+=*/site-packages/*,*/node_modules/*,*.pyc

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

set laststatus=2
set showtabline=2


" DetectIndent plugin settings
au BufReadPost * :DetectIndent
let g:detectindent_preferred_expandtab = 0
let g:detectindent_preferred_indent = 4

" Load local overrides/settings
source $HOME/.rcola/local/vimrc
