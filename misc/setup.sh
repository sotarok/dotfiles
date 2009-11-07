#!/bin/sh


if test $# != 1
then
    echo " unexpected args: setup.sh [directory of dotfiles]"
    exit 1
fi

DOTFILES=$1

ln -sf $DOTFILES/vim/.vim $HOME
ln -sf $DOTFILES/vim/.vimrc $HOME
ln -sf $DOTFILES/vim/.gvimrc $HOME
ln -sf $DOTFILES/zsh/.zshrc $HOME
ln -sf $DOTFILES/zsh/.dircolors $HOME
ln -sf $DOTFILES/zsh/.zshrc.d $HOME
ln -sf $DOTFILES/screen/.screenrc $HOME
ln -sf $DOTFILES/misc/.my.cnf $HOME
ln -sf $DOTFILES/misc/.gitconfig $HOME
touch $HOME/.outputz

if test ! -d $HOME/bin
then
    mkdir $HOME/bin
fi

ln -sf $DOTFILES/bin/* $HOME/bin
