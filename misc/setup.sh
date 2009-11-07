#!/bin/sh


if test $# != 1
then
    echo " unexpected args: setup.sh [directory of dotfiles]"
    exit 1
fi

DOTFILES=$1

ln -s $DOTFILES/vim/.vim $HOME
ln -s $DOTFILES/vim/.vimrc $HOME
ln -s $DOTFILES/vim/.gvimrc $HOME
ln -s $DOTFILES/zsh/.zshrc $HOME
ln -s $DOTFILES/zsh/.dircolors $HOME
ln -s $DOTFILES/zsh/.zshrc.d $HOME
ln -s $DOTFILES/screen/.screenrc $HOME
ln -s $DOTFILES/misc/.my.cnf $HOME
ln -s $DOTFILES/misc/.gitconfig $HOME
touch $HOME/.outputz

if test ! -d $HOME/bin
then
    mkdir $HOME/bin
fi

ln -s $DOTFILES/bin/* $HOME/bin
