####
# .zshrc file
#
# Maintainer  : Sotaro KARASAWA <sotaro.k@gmail.com>
# Version     : $Id
####

export LANG=ja_JP.UTF-8

# パスの設定
PATH=$HOME/bin:/usr/gnu/bin:/opt/local/bin:/usr/local/bin:$PATH:/sbin:/usr/sbin
export MANPATH=/usr/local/man:/usr/share/man

LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

# エディタを vim に設定
export SVN_EDITOR="vim"
export EDITOR="vim"
export CLICOLOR=1
export GTEST_COLOR=1
# export SCREENDIR=$HOME/.screen
export LSCOLORS=ExFxCxDxBxegedabagacad

#for Go
export GOROOT=$HOME/go
export GOOS=linux
export GOARCH=386
export GOBIN=$HOME/bin
#export PATH=$GOBIN:$PATH

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }
grepv () { grep -irn --binary-files=without-match $@ * | grep -v svn }
touchtodaytxt () {
    TODAY=`date +%Y-%m-%d`
    if [ $1 ]; then
        suffix="-"$1
    else
        suffix=""
    fi
    echo "= "${TODAY}" =" >> ${TODAY}${suffix}.txt
}

fpath=(~/.zshrc.d/completion $fpath)

# エイリアスの設定
# (dircolorの読み込み)
case "${OSTYPE}" in
darwin*)
    alias ls='ls -G'
    ;;
solaris*)
    test -f ~/.dircolors && eval `dircolors -b ~/.dircolors`
    alias ls='ls --color=auto'
    ;;
linux*)
    test -f ~/.dircolors && eval `dircolors -b ~/.dircolors`
    alias ls='ls --color=auto'
    ;;
esac

# ファイルがあれば読み込み
test -f $HOME/.zshaliases && source $HOME/.zshaliases


## 補完候補の色づけ
export ZLS_COLORS=$LS_COLORS

# 補完の利用設定
autoload -Uz compinit; compinit -u

# 大文字・小文字を区別しないで補完出来るようにする．大文字を入力した場合は区別
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin


# for typo
alias dc='cd'
alias d='cd'
alias sl='ls'
alias pc='cp'
alias pera='pear'
alias snv='svn'
alias gti='git'
alias gh='hg'
alias amke='make'

# for shortcut
alias t='tar zxvf'
alias tj='tar jxvf'
alias t-='tar xvf -'
alias b='bzip2 -dc'
alias ll='ls -ltr'
alias la='ls -la'
alias dh='df -h'
alias less='less -R'
alias grep='grep --color'
alias vi='vim'
alias v='vim'
alias e='vim'   # :p
alias sr='screen -d -R' # screen detach & resume
alias sR='screen -R' # screen detach & resume
alias sx='screen -x'    # screen multiattach
alias scl='screen -list' # screen list
alias scr='screen -r'    # screen r
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias pingg='ping www.google.com'
alias shr='sudo service httpd restart'
alias shs='sudo service httpd start'
alias sar='sudo service apache2 restart'
alias sas='sudo service apache2 start'
alias sl2='svn log --limit 2 --verbose | less'
alias sl3='svn log --limit 3 --verbose | less'
alias sl4='svn log --limit 4 --verbose | less'
alias sl5='svn log --limit 5 --verbose | less'
alias sl6='svn log --limit 6 --verbose | less'

# for svn
alias st='svn st | less -FSRX'
alias stu='svn st -u | less -FSRX'
alias sd='svn di | less -FSRX'
alias sdi='svn diff | colordiff | less -FSRX'
alias sad='svn add'
alias sup='svn up'
alias sci='svn ci'

# for git
alias gst='git status'
alias gci='git commit'
alias gdi='git diff'
alias gdc='git diff --cached'
alias gad='git add'
alias gb='git branch -a'
alias glg='git log --graph'
alias glag='git log --all --graph'
alias gsup='git stash; git svn rebase ; git stash pop'
alias gsci='git stash; git svn dcommit ; git stash pop'

# for sudo
alias yum='sudo yum'
alias aptitude='sudo aptitude'
alias apts='aptitude search'
alias apti='aptitude install'

# プロンプトの設定
autoload colors

# git branch data
_set_env_git_current_branch() {
    GIT_CURRENT_BRANCH=$( git name-rev HEAD --name-only ) &> /dev/null
}

_update_rprompt () {
    if test -z $GIT_CURRENT_BRANCH
    then
        RPROMPT=" %{[${PROMPT_COLOR}m%}[%~]%{[m%}"
    else
        RPROMPT=" %{[${PROMPT_COLOR}m%}[%~ ("$GIT_CURRENT_BRANCH")]%{[m%}"
    fi
}

case ${UID} in
0)
    PROMPT="%B%{[31m%}%n@%m#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%[m%}%b "
    #[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        #PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
;;
*)
    PROMPT_COLOR=32
    precmd() {
        PROMPT_COLOR="$[32 + ($PROMPT_COLOR - 31) % 5]"
        PROMPT="%{[${PROMPT_COLOR}m%}%n%%%{[m%} "
        PROMPT2="%{[${PROMPT_COLOR}m%}%_%%%{[m%} "

        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"

        _update_rprompt
    }

    #PROMPT="%{[32m%}%n%%%{[m%} "
    #PROMPT2="%{[32m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    #[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    #    PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
;;
esac

setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## 補完候補を一覧表示
setopt auto_list

# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# 履歴ファイルに時刻を記録
setopt extended_history

# 補完するかの質問は画面を超える時にのみに行う｡
LISTMAX=0


# cdのタイミングで自動的にpushd
setopt auto_pushd

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完機能Off
#setopt no_auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt NO_beep

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# cd -[TAB] で以前移動したディレクトリの候補
setopt pushd_ignore_dups

# auto_pushdで重複するディレクトリは記録しない
setopt correct

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt NO_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit

# シェルのプロセスごとに履歴を共有
setopt share_history

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='|*?_-.[]~=&;!#$%^(){}<>'

# ディレクトリを水色にする｡
#export LS_COLORS='di=01;36'


# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt NO_flow_control

# 改行がなくても表示
unsetopt promptcr

# ジョブ
unsetopt hup
setopt nocheckjobs

# Ctrl-s を無効
stty stop undef

# Emasc 風キーバインド
bindkey -e

set kanji-code utf-8
set convert-meta off    #必須
set meta-flag on        #必須
set output-meta on      #必須
set input-meta on
set enable-keypad on

# screen のステータスバーに現在実行中のコマンドを表示
# cd をしたときにlsを実行する
# git の branch を表示する
# ref. http://nijino.homelinux.net/diary/200206.shtml#200206140
#if [ "$TERM" = "screen" ]; then
chpwd () {
    _set_env_git_current_branch
    echo -n "_`dirs`\\"
    ls
}
preexec() {
# see [zsh-workers:13180]
# http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
        fg)
        if (( $#cmd == 1 )); then
            cmd=(builtin jobs -l %+)
        else
            cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
    %*) 
        cmd=(builtin jobs -l $cmd[1])
        ;;
    cd)
        if (( $#cmd == 2)); then
            cmd[1]=$cmd[2]
                fi
                ;&
                *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
    esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                echo -n "k$cmd[1]:t\\") 2>/dev/null
}
chpwd
#fi

