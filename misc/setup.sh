#!/bin/zsh

if test $# != 1
then
    echo " unexpected args: setup.sh [directory of dotfiles]"
    exit 1
fi

DOTFILES=$1

echo $HOME
echo $DOTFILES

ln -snf $DOTFILES/vim/.vim $HOME
ln -sf $DOTFILES/vim/.vimrc $HOME
ln -sf $DOTFILES/vim/.gvimrc $HOME
ln -snf $DOTFILES/zsh $HOME/.zsh
ln -sf $DOTFILES/zsh/.zshrc $HOME
ln -sf $DOTFILES/zsh/.dircolors $HOME
ln -sf $DOTFILES/screen/.screenrc $HOME
ln -sf $DOTFILES/tmux/.tmux.conf $HOME
ln -sf $DOTFILES/misc/.my.cnf $HOME
ln -sf $DOTFILES/misc/.gitconfig $HOME
ln -sf $DOTFILES/misc/.gitignore $HOME
ln -sf $DOTFILES/misc/.globalrc $HOME
ln -snf $DOTFILES/mocksmtpd/ $HOME/.mocksmtpd

test ! -d $HOME/bin && mkdir $HOME/bin

test ! -d $HOME/.ssh && mkdir $HOME/.ssh && chmod 700 $HOME/.ssh
cat $DOTFILES/ssh/authorized_keys | sort | uniq > $HOME/.ssh/authorized_keys_merged
test -f $HOME/.ssh/authorized_keys \
    && mv $HOME/.ssh/authorized_keys $HOME/.ssh/authorized_keys.orig \
    && cat $HOME/.ssh/authorized_keys.orig >> $HOME/.ssh/authorized_keys_merged
mv $HOME/.ssh/authorized_keys_merged $HOME/.ssh/authorized_keys && chmod 600 $HOME/.ssh/authorized_keys

test -f $HOME/.ssh/id_rsa.pub && mv $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub.orig
cp $DOTFILES/ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub && chmod 600 $HOME/.ssh/id_rsa.pub

ln -sf $DOTFILES/bin/* $HOME/bin

test ! -d $HOME/.anyenv \
    && git clone https://github.com/riywo/anyenv ~/.anyenv

## zinit
if test ! -d $HOME/.zinit ; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

cd $DOTFILES
git submodule update --init

if [ "$(uname)" = 'Darwin' ]; then
    run test -f /usr/local/bin/brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g KeyRepeat -int 1
    defaults write -g InitialKeyRepeat -int 11

    vim +BundleInstall +qall
fi
