#!/bin/sh


if test $# != 1
then
    echo " unexpected args: setup.sh [directory of dotfiles]"
    exit 1
fi

DOTFILES=$1

echo $HOME
echo $DOTFILES

ln -sf $DOTFILES/vim/.vim $HOME
ln -sf $DOTFILES/vim/.vimrc $HOME
ln -sf $DOTFILES/vim/.gvimrc $HOME
ln -sf $DOTFILES/zsh/.zshrc $HOME
ln -sf $DOTFILES/zsh/.dircolors $HOME
ln -sf $DOTFILES/zsh/.zshrc.d $HOME
ln -sf $DOTFILES/screen/.screenrc $HOME
ln -sf $DOTFILES/misc/.my.cnf $HOME
ln -sf $DOTFILES/misc/.gitconfig $HOME
ln -sf $DOTFILES/misc/.gitignore $HOME
ln -sf $DOTFILES/misc/.globalrc $HOME
touch $HOME/.outputz

if test ! -d $HOME/bin
then
    mkdir $HOME/bin
fi

cat $DOTFILES/ssh/authorized_keys | sort | uniq > $HOME/authorized_keys_merged
test ! -d $HOME/.ssh && mkdir $HOME/.ssh && chmod 700 $HOME/.ssh
test -f $HOME/.ssh/authorized_keys && mv $HOME/.ssh/authorized_keys $HOME/.ssh/authorized_keys.orig
mv $HOME/authorized_keys_merged $HOME/.ssh/authorized_keys && chmod 600 $HOME/.ssh/authorized_keys

ln -sf $DOTFILES/bin/* $HOME/bin
