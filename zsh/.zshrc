####
# .zshrc file
#
# Maintainer  : Sotaro KARASAWA <sotaro.k@gmail.com>
# LICENSE: Public Domain
####

#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8

# パスの設定
PATH=$HOME/bin:$HOME/local/bin:/usr/gnu/bin:/usr/local/bin:/opt/local/bin:$PATH:/sbin:/usr/sbin
export MANPATH=/usr/local/man:/usr/share/man

export ETHNA_HOME=$HOME/working/ethna/work
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

REPORTTIME=5

# エディタを vim に設定
export SVN_EDITOR="vim"
export EDITOR="vim"
export CLICOLOR=1
export GTEST_COLOR=1
# export SCREENDIR=$HOME/.screen
export LSCOLORS=ExFxCxDxBxegedabagacad

#for Go
export GOPATH=$HOME/.go
#export GOROOT=$HOME/go
#export GOOS=linux
#export GOARCH=$(arch)
#export GOBIN=$HOME/bin

#for aws
export JAVA_HOME=/usr
export AWS_RDS_HOME=$HOME/aws/RDSCli-1.4.006
export PATH=$AWS_RDS_HOME/bin:$PATH
export EC2_CERT=$HOME/aws/cert-X2E4GDTRX72W7XJ5AM4JRPOTSIXQYFTY.pem
export EC2_PRIVATE_KEY=$HOME/aws/pk-X2E4GDTRX72W7XJ5AM4JRPOTSIXQYFTY.pem
export EC2_URL=https://ec2.ap-northeast-1.amazonaws.com
export EC2_REGION=ap-northeast-1

# for aws (crocos)
test -f /usr/local/var/aws-tools/env/.bootstrap && source /usr/local/var/aws-tools/env/.bootstrap && source /usr/local/var/aws-tools/env/crocos

export SCREEN_USING=1
#export PATH=$GOBIN:$PATH

export DEBEMAIL="sotarok@crocos.co.jp"
export DEBFULLNAME="Sotaro Karasawa"

export LESS=' -R'
test -f /usr/share/source-highlight/src-hilite-lesspipe.sh && export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

# プロンプトの設定
autoload -U colors; colors

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }
grepv () { grep -irn --binary-files=without-match $@ * | grep -v svn | grep -v .git }
grep-edit () { vim $(grep $@ | cut -d: -f1  | sort | uniq) }
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
    test -f ~/.dotfiles/zsh/dircolors-solarized/dircolors.ansi-universal && eval `dircolors -b ~/.dotfiles/zsh/dircolors-solarized/dircolors.ansi-universal`
    alias ls='ls --color=auto'

    # mac の zsh だと関数が最初にパースれちゃう？
    # (which git の時点で関数/aliasが適用されてしまうのでlinuxのみ
    #alias git='git-wrap'
    ;;
esac


## 補完候補の色づけ
export ZLS_COLORS=$LS_COLORS

# 補完の利用設定
autoload -Uz compinit; compinit -u

# 大文字・小文字を区別しないで補完出来るようにする．大文字を入力した場合は区別
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 今いるディレクトリは補完候補に出さない
zstyle ':completion:*' ignore-parents parent pwd

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin


autoload -Uz is-at-least
if is-at-least 4.3.10; then
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "(+'~') "
  zstyle ':vcs_info:git:*' unstagedstr "(*'-') "
  zstyle ':vcs_info:*' actionformats " %F{1}%c%u%f%F{3}@%F{4}%b%F{3} !!%F{1}%a ( > <)%f"
  zstyle ':vcs_info:*' formats       " %F{1}%c%u%f%F{3}@%F{4}%b%f"
fi

#RPROMPT="%F{5}[%F{2}%~\${vcs_info_msg_0_}%F{5}]%f"
PROMPT_HEADER="%F{5}%F{2}%~\${vcs_info_msg_0_}%F{5}%f"

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
        vcs_info
        PROMPT_COLOR="$[32 + ($PROMPT_COLOR - 31) % 5]"

        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
            PRE_PROMPT="%{[37m%}${HOST%%.*} "

        PROMPT="${PRE_PROMPT}%F{${PROMPT_COLOR}}%n%%%f $PROMPT_HEADER
%% "
    }

    SPROMPT="%{$fg[red]%}%{$suggest%}(*･･%)? < %B%r%b %{$fg[red]%}? [y,n,a,e]:${reset_color} "
;;
esac

# for typo
alias ....='cd ../../'
alias dc='cd'
alias d='cd'
alias sl='ls'
alias ks='ls'
alias pc='cp'
alias pera='pear'
alias snv='svn'
alias gti='git'
alias gh='hg'
alias amke='make'

# for shortcut
alias sudo='sudo -E '
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
alias grep='grep --color'
alias grepl='grep --line-buffered'
alias t='tar zxvf'
alias tj='tar jxvf'
alias t-='tar xvf -'
alias b='bzip2 -dc'
alias ll='ls -ltr'
alias la='ls -la'
alias dh='df -h'
#alias less='less -R'
alias vi='vim'
alias v='vim'
alias :e='vim'
alias V='vim -R -'
alias e='vim'   # :p
alias pingg='ping www.google.com'

# for svn
alias st='svn st | less -FSRX'
alias stu='svn st -u | less -FSRX'
alias sd='svn di | less -FSRX'
alias sdi='svn diff | colordiff | less -FSRX'
alias sad='svn add'
alias sup='svn up'
alias sci='svn ci'
alias sl2='svn log --limit 2 --verbose | less'
alias sl3='svn log --limit 3 --verbose | less'
alias sl4='svn log --limit 4 --verbose | less'
alias sl5='svn log --limit 5 --verbose | less'
alias sl6='svn log --limit 6 --verbose | less'

# for screen
alias sr='screen -d -R' # screen detach & resume
alias sR='screen -R' # screen detach & resume
alias sx='screen -x'    # screen multiattach
alias scl='screen -list' # screen list
alias scr='screen -r'    # screen r

# for tmux
alias tl='tmux ls'
alias tn='tmux new-session -s'
alias ta='tmux a -d -t'

# for git
alias gst='git status -sb'
alias gci='git commit'
alias gdi='git diff'
alias gdir='GIT_PAGER="less -r -I" git diff'
alias gdc='git diff --cached'
alias gdw='GIT_PAGER="less -rSX" gdi --word-diff'
alias gad='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gbm='git branch --merged'
alias gg='git graph'
alias gga='git graph --all'
alias gco='git checkout'
alias gm='git merge'
alias gr='git rebase'
alias gf='git fetch -ap'
alias gbc='git name-rev --name-only HEAD > /tmp/git-current-branch-sotarok;screen -X readbuf /tmp/git-current-branch-sotarok;rm /tmp/git-current-branch-sotarok'
alias gpsom='git push origin master'
alias gpsod='git push origin develop'
alias gplrod='git pull --rebase origin develop'

# for sudo
alias yum='sudo yum'
alias aptitude='sudo aptitude'
alias apt-get='sudo apt-get'
alias apts='apt-cache search'
alias apti='apt-get install'
alias aptu='apt-get update'
alias aptug='apt-get upgrade'

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

setopt globsubst

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

r() {
  local f
  f=(~/.zshrc.d/completion/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

###########################
#
# Plugin
#
###########################

#GIT PATH
GITBIN=$(which git)

# php-env
test -d $HOME/.phpenv \
    && PATH="$HOME/.phpenv/bin:$PATH" \
    && eval "$(phpenv init -)"

# rvm
test -s "$HOME/.rvm/scripts/rvm" && source "$HOME/.rvm/scripts/rvm" \
    && rvm default \
    && PATH="$HOME/.rvm/scripts/rvm/gems/$(rvm current)/bin":$PATH

# for gcloud
source $HOME/google-cloud-sdk/path.zsh.inc
source $HOME/google-cloud-sdk/completion.zsh.inc

# nvm
export NVM_DIR=$HOME/.nvm
test -f $NVM_DIR/nvm.sh && source $NVM_DIR/nvm.sh

# autojump
test -f ~/.dotfiles/zsh/autojump.zsh && source ~/.dotfiles/zsh/autojump.zsh

# ファイルがあれば読み込み
test -f $HOME/.zshaliases && source $HOME/.zshaliases

# plugin
#source ~/.zshrc.d/plugin/*


###########################
#
# Auto ls
#
###########################

# screen のステータスバーに現在実行中のコマンドを表示
# cd をしたときにlsを実行する
chpwd () {
    case "${OSTYPE}" in
        darwin*) ;;
    *)
        echo -n "_`dirs`\\"
        ls
        ;;
    esac
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

    if test $SCREEN_USING -eq 1
    then
        $cmd >>(read num rest
        cmd=(${(z)${(e):-\$jt$num}})
        echo -n "k$cmd[1]:t\\") 2>/dev/null
    fi
}
chpwd

# zaw
test -f ~/.dotfiles/zsh/zaw/zaw.zsh && source ~/.dotfiles/zsh/zaw/zaw.zsh
bindkey '^Xd' zaw-cdr
bindkey '^Xf' zaw-git-files
bindkey '^Xg' zaw-git-branches
bindkey '^X@' zaw-gitdir
