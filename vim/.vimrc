" .vimrc file
"
" Maintainer:   Sotaro KARASAWA <sotaro.k@gmail.com>
" Version:      $Id$
"
"""""

" 環境依存な設定を読み込む
if has("unix")
    " linux
    set rtp+=$HOME/.vim/env/unix
elseif has('mac')
    " mac
    set rtp+=$HOME/.vim/env/mac
elseif has("win32")
    " windows
    set rtp+=$HOME/.vim/env/win32
endif

" Git コマンドがあれば Git 関連のプラグイン
if executable('git')
    set rtp+=$HOME/.vim/env/git
endif

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"""""
" ftplugin
"""""
autocmd!
filetype plugin indent on

"""""
" Initialize Settings
"""""
set nocompatible
set history=999
set encoding=utf-8

" Edit .vimrc
nnoremap <Space>.  :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
" view Help
"nnoremap <C-h>       :<C-u>help<Space>
"nnoremap <C-h><C-h>  :<C-u>help<Space><C-r><C-w><Enter>

"""""
" Status line Settings
"""""
set laststatus=2
set ruler
set title
set showcmd
set showmode
" statuslineの表示設定。GetB()呼び出しも実行
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ [%{GetB()}]%=%l,%c%V%8P
" コマンドの補完をシェルっぽく
set wildmode=list:longest

"""""
" Behavior Settings
"""""
set backspace=indent,eol,start
set autoindent smartindent
set incsearch
" 検索文字列が小文字のときはCaseを無視。大文字が混在している場合は区別する。
set ignorecase
set smartcase
set wrapscan
" バッファが編集中でもファイルを開けるようにする
set hidden
" 編集中のファイルが外部のエディタから変更された場合には、自動で読み直し
set autoread
" tagsディレクトリを探し出してctagsを有効にする
if has("autochdir")
    set autochdir
    set tags=tags;
endif
" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"""""
" View window Settings
"""""
set list
set listchars=tab:\ \ 
set number
set showmatch
set hlsearch
set wrap
set visualbell
set expandtab
set ts=4
set shiftwidth=4

" key mapping
nmap n nzz
nmap N Nzz
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>Q :<C-u>quit!<CR>

" buffer
nnoremap <Space>h :<C-u>bp<CR>
nnoremap <Space>j :<C-u>bn<CR>
nnoremap <Space>d :<C-u>bd<CR>
nnoremap <Space><Space> :<C-u>buffers<CR>

nnoremap <Space>O O^<C-D><Esc>
nnoremap <Space>o o^<C-D><Esc>

" coursor
noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

inoremap <C-@> <Esc>
"inoremap <Space>[ <Esc>

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd BufEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline

" when split vertical then Vexplore
nnoremap <C-w><C-v> :<C-u>Vexplore<Enter>

"""""
" Japanese Settins by ずんWik
"
" 文字コードの自動認識
"""""
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"""""
" Highlight Settings
"""""
syntax on
hi Comment ctermfg=Red
hi Function ctermfg=cyan


"""""
" 編集時用設定 

"""""

" 拡張子によってファイル判定
augroup filetypedetect
    au! BufRead,BufNewFile *.ctp setfiletype php
    au! BufRead,BufNewFile *.xul setfiletype xul
    au! BufRead,BufNewFile *.jsm setfiletype javascript
    au! BufRead,BufNewFile *.go  setfiletype go
augroup END

set helpfile=$VIMRUNTIME/doc/help.txt

if has("autocmd")
    autocmd FileType rb :setlocal dictionary+=~/.vim/dict/ruby.dict
    autocmd FileType pl :setlocal dictionary+=~/.vim/dict/perl.dict
    autocmd FileType pm :setlocal dictionary+=~/.vim/dict/perl.dict

    autocmd FileType c setlocal ts=2 sw=2
    autocmd FileType smarty setlocal ts=2 sw=2
    autocmd FileType make setlocal nomodeline noexpandtab
    autocmd FileType yaml setlocal ts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sw=2

    autocmd BufNewFile *.php 0r ~/.vim/skeleton/php.skel
    autocmd BufNewFile *.py 0r ~/.vim/skeleton/python.skel
    autocmd BufNewFile *.rb 0r ~/.vim/skeleton/ruby.skel
    autocmd BufNewFile *.pl 0r ~/.vim/skeleton/perl.skel
    autocmd BufNewFile *.html 0r ~/.vim/skeleton/html.skel
    autocmd BufNewFile *.tpl 0r ~/.vim/skeleton/html.skel
    autocmd BufNewFile *.cpp 0r ~/.vim/skeleton/cpp.skel

    " バッファの。。。なんかよくわからんけど追加。あとで。
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    autocmd Filetype *
                \   if &omnifunc == "" |
                \           setlocal omnifunc=syntaxcomplete#Complete |
                \   endif

endif

" yankringの割り当て変更
if has("viminfo")
    " yankrignによるviminfoの編集の問題らしい。こうしておかないと、yankringにおこられる。
    set vi^=!
endif
nmap ,y :YRShow<CR>


"""""
" 上下キーで実行 or Lint
"""""

autocmd FileType c :nmap <up>   <esc>:w<cr>:!gcc % && ./a.out<cr>

autocmd FileType perl  :nmap <up>   <esc>:w<cr>:!/usr/bin/env perl %<cr>
autocmd FileType perl  :nmap <down> <esc>:w<cr>:!/usr/bin/env perl -cw %<cr>

autocmd FileType ruby  :nmap <up>   <esc>:w<cr>:!/usr/bin/env ruby %<cr>
autocmd FileType ruby  :nmap <down> <esc>:w<cr>:!/usr/bin/env ruby -c %<cr>

autocmd FileType python :nmap <up>  <esc>:w<cr>:!/usr/bin/env python %<cr>


let nohl_xul_atts = 1

"""""
" mini buffer explorer プラグイン用設定
"""""
"let g:miniBufExplMapWindowNavVim=1 "hjklで移動
"let g:miniBufExplSplitBelow=0  " Put new window above
"let g:miniBufExplMapWindowNavArrows=1
"let g:miniBufExplMapCTabSwitchBufs=1
"let g:miniBufExplModSelTarget=1 
"let g:miniBufExplSplitToEdge=1


"""""
" Add Functions
"""""

" GetB
" カーソル上の文字のバイナリコードを表示してくれる。
"""""
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

" /GetB
"""""

""""
" buftabs
"バッファタブにパスを省略してファイル名のみ表示する(buftabs.vim)
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1


"Tab文字も区別されずにハイライトされるので、区別したいときはTab文字の表示を別に
"設定する必要がある。
function! SOLSpaceHilight()
    "syntax match SOLSpace "^\s\+" display containedin=ALL
    "highlight SOLSpace term=underline ctermbg=Gray
endf

"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call SOLSpaceHilight()
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif

"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set list
set listchars=tab:^_,trail:-,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=darkcyan guifg=darkcyan

"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf


" if &term == "xterm-color"
"     set t_kb=
"     fixdel
" endif

"""
" NeoComplCache
"""
"let g:NeoComplCache_EnableAtStartup=1
" 辞書ファイルリスト
let g:NeoComplCache_DictionaryFileTypeLists = {
    \ 'default' : '',
    \ 'php' : $HOME . '/.vim/dict/php.dict'
\ }
" 入力文字がこれ以上だと補完しない
let g:NeoComplCache_MaxTryKeywordLength=100
" 大文字小文字無視
let g:NeoComplCache_IgnoreCase=1
" 大文字を最初に入力したら補完しない
let g:NeoComplCache_MaxList=1000
let g:NeoComplCache_SmartCase=1
let g:NeoComplCache_EnableUnderbarCompletion=1
let g:NeoComplCache_PartialMatch=0
let g:NeoComplCache_AlphabeticalOrder=1
let g:NeoComplCache_CacheLineCount=1000
let g:NeoComplCache_MinKeywordLength=4
let g:NeoComplCache_EnableQuickMatch=0


" AutoComplPop
inoremap <expr> <CR> pumvisible() ? "\<C-p>\<CR>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-Y>" : "\<Tab>"

" gtags
    " 検索結果Windowを閉じる
    nnoremap <C-q> <C-w><C-w><C-w>q
    " Grep 準備
    nnoremap <C-g> :Gtags -r
    " このファイルの関数一覧
    nnoremap <C-l> :Gtags -f %<CR>
    " カーソル以下の定義元を探す
    nnoremap <C-j> :Gtags <C-r><C-w><CR>
    " カーソル以下の使用箇所を探す
    nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
    " 次の検索結果
    nnoremap <C-n> :cn<CR>
    " 前の検索結果
    nnoremap <C-p> :cp<CR>

