set nocompatible

if has('nvim')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
endif

execute pathogen#infect()
Helptags

" Appearance options
set nu rnu
syntax on
"let g:solarized_termcolors=256
"set bg=dark
"colo solarized
colo seoul256
set display=uhex

" Tabbing options
set ts=4 sw=4
set expandtab
set autoindent
set smartindent
"set inde=''      " Turn off annoying reidenting of current line
set smarttab
set sr

set showmatch matchtime=1   " Jump quickly back to matching parens et al
set magic                   " Backslashes in regexes less necessary
set ignorecase smartcase    " Smart casing for search
set dir=$HOME/.vim/swap     " Swap file location
set mouse=n                 " Mouse enabled in normal mode
set keywordprg=:help        " K uses :help
set grepprg=ag              " Use the silver searcher for :grep
set ruler
set cul
set autowrite
set hidden

" Undo history
set undofile
set undodir=$HOME/.vim/undo

"set tags=./tags;

filetype plugin indent on
au FileType * setlocal comments-=:// comments+=f://

" Languages for some filetypes
au BufNewFile,BufRead *.asm setf nasm
au BufNewFile,BufRead *.inc setf nasm
au BufNewFile,BufRead *.jsm setf javascript

" Browse jars and bundles as zip files
au BufReadCmd *.jar,*.bundle call zip#Browse(expand("<amatch>"))

" Tags for languages
au FileType python setlocal tags=./tags,tags,$HOME/.vim/tags/python3

" Move new help windows to right
"au FileType help wincmd L | set bh=unload

" Highlight extra whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Prefix for custom shortcuts
let mapleader = "-"

" Highlight words under the cursor
function! MatchUnderCursor()
  if exists('w:cursor_match_id')
    silent! call matchdelete(w:cursor_match_id)
  endif
  let w:cursor_match_id = matchadd('WordUnderCursor', '\<' . expand('<cword>') . '\>')
endfunction
au InsertChange * :call MatchUnderCursor()
au CursorMoved * :call MatchUnderCursor()
au CursorMovedI * :call MatchUnderCursor()
highlight WordUnderCursor cterm=underline gui=underline

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
nnoremap <Leader>/ :LGrep 
nnoremap <Leader>? :LGrep <cword>
nnoremap <Leader>' :NERDTreeToggle<Cr>
nnoremap <Leader>n :set nu! rnu!<Cr>
nnoremap <Leader>] :tab <cword><Cr>

nnoremap <Leader>h :execute ":help " . expand("<cword>")<Cr>

"nnoremap <Leader>h ^
"nnoremap <Leader>l $

" Fixlist
nnoremap <Leader>F :lopen<Cr>
nnoremap <Leader>f :lnext<Cr>

" Git commands
nnoremap <Leader>gb :Gblame<Cr>
nnoremap <Leader>gd :Gdiff<Cr>
nnoremap <Leader>gl :Gllog<Cr>:lopen<Cr>

" Python import commands
nnoremap <Leader>ip :ImportName<Cr>
nnoremap <Leader>iP :ImportNameHere<Cr>

" Custom commands
command! Ev e $MYVIMRC
command! Sv so $MYVIMRC
command! Elv e $HOME/.rcola/local/vimrc
command! Slv so $HOME/.rcola/local/vimrc
command! DiscardUndos set undoreload=0 | edit | set undoreload=10000
command! -nargs=+ -complete=function LGrep lgrep! <args> | lopen
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

" Nerd tree options
let g:NERDTreeWinSize = 50

" Gutentag options
let g:gutentags_ctags_exclude = ['*mypy*']

" Load local overrides/settings
source $HOME/.rcola/local/vimrc
