set nocompatible

if has('nvim')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
endif

call plug#begin()
Plug 'godlygeek/tabular'
Plug 'sjrct/detectindent'
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-airline/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'simnalamburt/vim-mundo'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'peitalin/vim-jsx-typescript'
call plug#end()

" Appearance options
set nu rnu
syntax on
set display=uhex
set signcolumn=number

" Tabbing options
set ts=4 sw=4
set expandtab
set autoindent
set smartindent
"set inde=''      " Turn off annoying reidenting of current line
set smarttab
set sr

set backspace=indent,eol,start " Allow backspacing over things not inserted
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
au FileType kotlin setlocal tags=./tags,tags,$HOME/.vim/tags/kotlin

" Help for different filetype
au FileType sh,zsh,make,dockerfile setlocal keywordprg=:Man
au FileType vim,help setlocal keywordprg=:help

if has('nvim')
  au TermOpen * setlocal keywordprg=:Man
endif

au FileType man setlocal linebreak

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
  let w:cursor_match_id = matchadd('WordUnderCursor', '\V\<' . escape(expand('<cword>'), '\') . '\>', -1)
endfunction
au InsertChange * :call MatchUnderCursor()
au CursorMoved * :call MatchUnderCursor()
au CursorMovedI * :call MatchUnderCursor()
highlight WordUnderCursor cterm=underline gui=underline

" Scratch pad support
function! Scratch()
  let l:bufname = '\[scratch]'
  if bufwinnr(l:bufname) != -1
    exec 'b ' . l:bufname
  else
    new
    exec 'file ' . l:bufname
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
  endif
endfunction
nnoremap <Leader>x :call Scratch()

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
nnoremap <Leader>? :LGrep <C-R>=expand("<cword>")<Cr> -ws
nnoremap <Leader>' :NERDTreeToggle<Cr>
nnoremap <Leader>n :set nu! rnu!<Cr>
nnoremap <Leader>] :tab <cword><Cr>
nnoremap <Leader>u :MundoToggle<Cr>
vnoremap @ y:@"<Cr>

" -t for hints in typescript
"autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
autocmd FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <silent> K :call CocAction('doHover')<CR>
autocmd FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <silent> <C-]> <Plug>(coc-definition)

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>D <Plug>(coc-declaration)
nmap <silent> <leader>t <Plug>(coc-type-definition)
nmap <silent> <leader>r <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-@> coc#start()

"nnoremap <Leader>h :execute ":help " . expand("<cword>")<Cr>

" Terminal mode stuff
function! TermStartup()
  normal isource ~/.vim/termrc<Esc>
  startinsert
endfunction

if has('nvim')
  "autocmd TermOpen * call TermStartup
  autocmd TermOpen * startinsert
endif

" Hopefully these are not too problematic
tnoremap <Esc> <C-\><C-N> 
tnoremap <C-W> <C-\><C-N><C-W>

nnoremap <Leader>h ^
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
set wildignore+=*/site-packages/*,*/node_modules/*,*.pyc,*/build/*

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
" Let CoC handle js/ts[x]
"let g:gutentags_ctags_exclude = ['*mypy*', '*.js', '*.ts', '*.jsx', '*.tsx']
let g:gutentags_ctags_exclude = ['*mypy*']

" Mundo opts
let g:mundo_preview_bottom = 1
let g:mundo_right = 1

" Syntastic options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-eslint' ]

" Load local overrides/settings
source $HOME/.rc/local/vimrc
