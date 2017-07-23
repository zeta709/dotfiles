call plug#begin('~/.vim/plugged')

"" color-scheme
Plug 'altercation/vim-colors-solarized'

"" project
Plug 'scrooloose/nerdtree'

"" tags
Plug 'majutsushi/tagbar'

"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

map <C-n> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
