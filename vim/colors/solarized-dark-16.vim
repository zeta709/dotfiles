syntax enable
set background=dark
let g:solarized_termtrans=1
let s:path=fnamemodify(resolve(expand("<sfile>:p")), ":h")
exec "source " . s:path . "/solarized.vim"
