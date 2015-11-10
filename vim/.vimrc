" .vimrc file
"
" Maintainer:   Sotaro KARASAWA <sotaro.k@gmail.com>
"""""

" 環境依存な設定を読み込む
"if has("unix")
"    " linux
"    set rtp+=$HOME/.vim/env/unix
"elseif has('mac')
"    " mac
"    set rtp+=$HOME/.vim/env/mac
"elseif has("win32")
"    " windows
"    set rtp+=$HOME/.vim/env/win32
"endif
"
"" Git コマンドがあれば Git 関連のプラグイン
"" この rtp うまくいかないお
"if executable('git')
"    set rtp+=$HOME/.vim/env/git
"endif

" {{{ Vundle Setting
" """"""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

"Bundle 'tpope/vim-fugitive'                  " original repos on github
"Bundle 'rails.vim'                           " vim-scripts repos
"Bundle 'git://git.wincent.com/command-t.git' " non github repos
Bundle 'tpope/vim-surround'
if $SUDO_USER == ''
  Bundle 'Shougo/neomru.vim'
  Bundle 'Shougo/unite.vim'
  Bundle 'Shougo/neocomplcache'
  Bundle 'Shougo/unite-outline'
endif
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'groenewege/vim-less'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'Blackrush/vim-gocode'
Bundle 'pangloss/vim-javascript'
Bundle 'chase/vim-ansible-yaml'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'plasticboy/vim-markdown'
" vim-script Plugins
Bundle 'sudo.vim'
Bundle 'buftabs'
Bundle 'Align'
" colorscheme
Bundle 'molokai'
Bundle 'chriskempson/vim-tomorrow-theme'
" trying
"Bundle 'kien/ctrlp.vim'
"Bundle 'Lokaltog/vim-powerline'

filetype plugin indent on
" }}}

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"""""
" Initialize Settings
"""""
set nocompatible
set history=999
set encoding=utf-8

set background=dark
"colorscheme molokai
colorscheme Tomorrow-Night

" Edit .vimrc
"nnoremap <Space>.  :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

"""""
" Status line Settings
"""""
set laststatus=2
set ruler
set title
set showcmd
set showmode
" statuslineの表示設定。GetB()呼び出しも実行
set statusline=%f%=%y%r%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ [%{GetB()}]%=%l,%c%V%6P

set wildmode=list:longest
"set wildmode=list,full
if v:version >= 703
  set wildignorecase
endif


" {{{ powerline
"let g:Powerline_mode_n = 'NORMAL'
" }}}


"""""
" Behavior Settings
"""""
set backspace=indent,eol,start
set autoindent smartindent
set incsearch
set smartcase
set ignorecase
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
set number
set showmatch
set hlsearch
set wrap
set visualbell
set expandtab
set ts=4
set shiftwidth=4
set foldmethod=marker

" key mapping
nmap * *N
nmap n nzz
nmap N Nzz
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>Q :<C-u>quit!<CR>

" paste / nopaste
nnoremap <Space>p  :set paste<CR>
nnoremap <Space>np :set nopaste<CR>

" buffer
nnoremap <Space>h :<C-u>bp<CR>
nnoremap <Space>j :<C-u>bn<CR>
nnoremap <Space>d :<C-u>bd<CR>
nnoremap <Space><Space> :<C-u>buffers<CR>

" C-p で連続貼り付け
nnoremap <silent> <C-p> "0p<CR>
vnoremap <silent> <C-p> "0p<CR>

" insert date
nnoremap <C-d> :r! date +'\%Y-\%m-\%d \%H:\%M:\%S'<CR>
" insert email sign
nnoremap <C-@> :r! echo -n "$(git config --global user.name) " ; echo -n "<$(git config --global user.email)>"<CR>

nnoremap <Space>O O^<C-D><Esc>j
nnoremap <Space>o o^<C-D><Esc>k

" coursor
noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

" resize
noremap + <C-W>+
noremap + <C-W>>
noremap - <C-W>-
noremap - <C-W><

" for IME
inoremap <C-@> <Esc>
"inoremap <Space>[ <Esc>

" unite
nnoremap <C-i> :Unite file<Enter>
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 再帰的
nnoremap <silent> ,ue :<C-u>Unite buffer file_rec<CR>
" 最近使用したファイル一
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>


" unite-outline
nnoremap <C-u> :Unite outline<Enter>
let g:unite_data_directory="~/tmp/vim_unite_outline"


autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd BufEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline

" auto remove spaces of the end of line
autocmd BufWritePre * :%s/\s\+$//ge
"autocmd BufWritePre *.go Fmt

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

""""""
"" Highlight Settings
""""""
hi Comment ctermfg=Red
hi Function ctermfg=cyan
hi IncSearch ctermfg=Red
hi Search ctermfg=Red


"""""
" 編集時用設定
"""""

" 拡張子によってファイル判定
autocmd BufRead,BufNewFile *.ctp  setfiletype php
autocmd BufRead,BufNewFile *.xul  setfiletype xul
autocmd BufRead,BufNewFile *.jsm  setfiletype javascript
autocmd BufRead,BufNewFile *.go   setfiletype go
autocmd BufRead,BufNewFile *.scss setfiletype scss
autocmd BufRead,BufNewFile *.json setfiletype javascript
autocmd BufRead,BufNewFile *.twig setfiletype javascript
autocmd BufRead,BufNewFile *.twig setfiletype htmldjango
autocmd BufRead,BufNewFile *.twig if &filetype == 'twig' | set filetype=htmldjango | endif

if has("autocmd")
    autocmd FileType rb :setlocal dictionary+=~/.vim/dict/ruby.dict
    autocmd FileType pl :setlocal dictionary+=~/.vim/dict/perl.dict
    autocmd FileType pm :setlocal dictionary+=~/.vim/dict/perl.dict

    autocmd FileType * setlocal dictionary+=~/.vim/dict/facebook_permissions.dict textwidth=0

    autocmd FileType c setlocal ts=2 sw=2
    autocmd FileType text setlocal ts=4 sw=4
    autocmd FileType mkd setlocal ts=4 sw=4 sts=4
    autocmd FileType smarty setlocal ts=2 sw=2
    autocmd FileType make setlocal nomodeline noexpandtab
    autocmd FileType yaml setlocal ts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sw=2 sts=2 includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
    autocmd FileType html setlocal ts=2 sw=2 sts=2 includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
    autocmd FileType xml setlocal ts=2 sw=2 sts=2 includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
    autocmd FileType rst setlocal ts=2 sw=2 sts=2
    autocmd FileType css setlocal ts=2 sw=2 sts=2 includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
    autocmd FileType scss setlocal ts=2 sw=2 sts=2
    autocmd FileType less setlocal ts=2 sw=2 sts=2
    autocmd FileType go setlocal noexpandtab
    autocmd FileType php setlocal commentstring=\ //\ %s

    autocmd BufNewFile *.php 0r ~/.vim/skeleton/php.skel
    autocmd BufNewFile *.py 0r ~/.vim/skeleton/python.skel
    autocmd BufNewFile *.rb 0r ~/.vim/skeleton/ruby.skel
    autocmd BufNewFile *.pl 0r ~/.vim/skeleton/perl.skel
    autocmd BufNewFile *.html 0r ~/.vim/skeleton/html.skel
    autocmd BufNewFile *.tpl 0r ~/.vim/skeleton/html.skel
    autocmd BufNewFile *.cpp 0r ~/.vim/skeleton/cpp.skel
    autocmd BufNewFile *.sh 0r ~/.vim/skeleton/shell.skel
    autocmd BufNewFile *.zsh 0r ~/.vim/skeleton/shell.skel
    autocmd BufNewFile *.bash 0r ~/.vim/skeleton/shell.skel
    autocmd BufNewFile *.go 0r ~/.vim/skeleton/go.skel

    " バッファの。。。なんかよくわからんけど追加。あとで。
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    "autocmd Filetype *
    "            \   if &omnifunc == "" |
    "            \           setlocal omnifunc=syntaxcomplete#Complete |
    "            \   endif

endif

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

" zen-coding.vim
let g:user_zen_settings = {'indentation':'  '}


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
if exists("w:buftabs_enabled")
    set statusline=%{buftabs#statusline()}%=%y%r%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ [%{GetB()}]%=%l,%c%V%6P
endif

"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    syntax on
    augroup invisible
        autocmd! invisible
        "autocmd BufNew,BufRead * call JISX0208SpaceHilight()
        highlight IdeographicSpace term=underline ctermbg=LightCyan guibg=LightCyan
        autocmd VimEnter,WinEnter * match IdeographicSpace /　/
    augroup END
endif


"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set list
set listchars=tab:>.,trail:-,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=darkcyan guifg=darkcyan

if &term == "xterm-color"
    "set t_kb=
    fixdel
endif

" gtags
" 検索結果Windowを閉じる
nnoremap <Space>q <C-w><C-w><C-w>q
" Grep 準備
nnoremap <C-g> :Gtags -g
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
