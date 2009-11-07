colorscheme twilight2Rev2

scriptencoding utf-8

set showtabline=2  // タブを常に表示
set imdisable      // IMを無効化
set transparency=5 // 透明度を指定
set lines=45
set columns=180
map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

set nobackup

set list
set listchars=tab:^_,trail:-,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=darkcyan guifg=darkcyan
