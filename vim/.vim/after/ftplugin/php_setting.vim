
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" dictionary
setlocal dictionary+=~/.vim/dict/php.dict

" make
setlocal makeprg=php\ -l\ %\ 
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
setlocal shellpipe=2>&1\ >
nmap <up>   <esc>:w<cr>:!/usr/bin/env php %<Enter>
nmap <down> <esc>:w<cr>:make<cr><cr>
nmap ,l     <esc>:w<cr>:make<cr><cr>
let errormarker_errortext = "->"


"inoremap <expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
"inoremap <expr> ( smartchr#loop(' (', '(')
"inoremap <expr> ) smartchr#loop(') ', ') {', ')')
"inoremap <expr> ! smartchr#loop(' != ', ' !== ', '!')
"inoremap <expr> ! smartchr#loop(' != ', ' !== ', '!')
