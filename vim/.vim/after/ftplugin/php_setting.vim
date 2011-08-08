setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" dictionary
setlocal dictionary+=~/.vim/dict/php.dict

" make
setlocal makeprg=php\ -l\ %\ 
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
setlocal shellpipe=2>&1\ >
"nmap <up>   <esc>:w<cr>:!/usr/bin/env php %<cr>
nnoremap <up>   <esc>:w<cr>:!/usr/bin/env php %<cr>
inoremap <up>   <esc>:w<cr>:!/usr/bin/env php %<cr>
nnoremap [A   <esc>:w<cr>:!/usr/bin/env php %<cr>
inoremap <down> <esc>:w<cr>:make<cr><cr>
nnoremap <down> <esc>:w<cr>:make<cr><cr>
nnoremap [B   <esc>:w<cr>:make<cr><cr>
nnoremap ,l     <esc>:w<cr>:make<cr><cr>
let errormarker_errortext = "->"


"inoremap <expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
"inoremap <expr> ( smartchr#loop(' (', '(')
"inoremap <expr> ) smartchr#loop(') ', ') {', ')')
"inoremap <expr> ! smartchr#loop(' != ', ' !== ', '!')
"inoremap <expr> ! smartchr#loop(' != ', ' !== ', '!')
