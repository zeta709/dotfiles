"" This is file `dot-plugins.vim`.
" vim: set ft=vim et sw=2:

if exists('g:loaded_dot_plugins')
  finish
endif
let g:loaded_dot_plugins = 1

if !exists('g:plugs')
  echoerr 'plug#begin was not called'
  echomsg 'Include this file in your .vimrc as follows:'
  echohl MoreMsg
  echomsg "  call plug#begin('/path-to-plugged/.vim/plugged')"
  echomsg "  source /path-to-this/dot-plugins.vim"
  echomsg "  call plug#end()"
  echohl None
  finish
endif

"" project
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

"" tags
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

"" c,cpp
Plug 'rhysd/vim-clang-format'
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 0
let g:clang_format#auto_format_on_insert_leave = 0
"let g:clang_format#auto_formatexpr = 1
let g:clang_format#enable_fallback_style = 0
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

Plug 'octol/vim-cpp-enhanced-highlight'

"" python
Plug 'Vimjas/vim-python-pep8-indent'

"" FIXME: syntastic works but has minor bugs in terminal
"Plug 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"" misc
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/matchit.zip'

"" End of file `dot-plgin.vim`.
