"" documentation: <ESC>:help options

set number " nu
set display+=lastline " dy
set display+=uhex " dy
set incsearch " is
set visualbell " vb
set hlsearch " hls

if &history < 500
	set history=500
endif
"set complete-=i " do not scan included files for autocomplete

set wildmenu " command-line completion

set colorcolumn=80

set backspace=indent,eol,start

set cm=blowfish

"" statusline
set laststatus=2
"" http://www.vim.org/tips/tip.php?tip_id=735
if has("statusline")
set statusline=
set statusline+=%n:\         " buffer number and colon
set statusline+=%<%f\        " filename
set statusline+=[%M%R%H%W]   " flags: modified, readonly, help buffer, preview
set statusline+=[%{&fenc}    " file encoding
set statusline+=%{(exists(\"+bomb\")&&(&bomb))?\"\bomb\":\"\"} " bomb
set statusline+=,%{&ff}]     " file format
set statusline+=%y           " file type
set statusline+=[%3b,0x%02B] " character under cursor
set statusline+=%=%l,%c%V/%L " current line, column and total line
set statusline+=\ %p%%       " postion(%)
endif

"" temp directory setting for windows
"set directory=.,$TEMP


""""""""""""""""""""""""""""""""""""""""
"" encoding
""""""""""""""""""""""""""""""""""""""""

set enc=utf-8
set fenc=utf-8
set fencs=ucs-bom,utf-8,cp949,latin1
set nobomb


""""""""""""""""""""""""""""""""""""""""
"" syntax, indent
""""""""""""""""""""""""""""""""""""""""

"" default indent
set autoindent

set modeline
syntax on
filetype plugin indent on

"set formatoptions+=ro

"" for c,cpp
"nmap <C-J> vip=
"map <F5> gg=G``
au filetype c,cpp setlocal cindent
au filetype c,cpp setlocal noexpandtab
au filetype c,cpp setlocal tabstop=8
au filetype c,cpp setlocal shiftwidth=8
"au filetype c,cpp setlocal cinoptions=>2s,:0,=2s,l1,g0,h2s,p2s,t0,+s,(0,u0,w1
au filetype c,cpp setlocal cinoptions=:0,l1,g0,t0,(0,u0,w1
let c_space_errors=1

"" for tex
au FileType tex setlocal spell spelllang=en_us
au FileType tex map <F7> <ESC>:setlocal spell spelllang=en_us<CR>
au FileType tex map <F8> <ESC>:!pdflatex %<CR>
au FileType tex map <F9> <ESC>:!xelatex %<CR>

"" for python
au filetype python setlocal autoindent
au filetype python setlocal smarttab
au filetype python setlocal expandtab
au filetype python setlocal tabstop=8
au filetype python setlocal shiftwidth=4
au filetype python setlocal softtabstop=4

"" for git
au filetype gitcommit setlocal spell spelllang=en_us colorcolumn=50,72

"" for Markdown
au BufRead,BufNewFile *.md setlocal filetype=markdown
"au filetype markdown setlocal colorcolumn=120

"" for java
"let java_space_errors=1

"" space errors
"" space before tab
"syntax match mySpaceError " \+\t"me=e-1
"" trail white space
"syntax match mySpaceError excludenl "\s\+$"
"syntax match myLongLine /\%>80v.\+/
"hi def link mySpaceError Error
"hi def link myLongLine Error

"" cscope
"set csprg=/usr/bin/cscope
set cst
set csto=1
set nocsverb
let cscope_file = findfile("cscope.out", ".;")
"echo cscope_file
if !empty(cscope_file) && filereadable(cscope_file)
	let cscope_pre = strpart(cscope_file, 0, match(cscope_file, "/cscope.out$"))
	"echo cscope_pre
	exec "cs add" cscope_file cscope_pre
endif
set csverb

"" ctags
set tags=./tags;
