"" This is file `dot-plugins.vim`.

if exists('g:loaded_dot_plugins')
	finish
endif
let g:loaded_dot_plugins = 1

if !exists('g:plugs')
	echohl ErrorMsg
	echom 'plug#begin was not called'
	echohl None
	finish
endif

"" color-scheme
Plug 'altercation/vim-colors-solarized'

"" project
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

"" tags
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" vim-clang-format
Plug 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 1
"let g:clang_format#auto_formatexpr = 1
let g:clang_format#enable_fallback_style = 0
nnoremap <C-S-i> :ClangFormat<CR>

""
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/gv.vim'

"" End of file `dot-plgin.vim`.
