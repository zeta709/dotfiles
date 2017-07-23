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

"" End of file `dot-plgin.vim`.
