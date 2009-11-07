#!/bin/sh


if test $# != 1
then
    echo " unexpected args: setup.sh [directory of dotfiles]"
    exit 1
fi

DOTFILES=$1

ln -s $DOTFILES/vim/sotarok/.vim $HOME
ln -s $DOTFILES/vim/sotarok/.vimrc $HOME
ln -s $DOTFILES/vim/sotarok/.gvimrc $HOME
ln -s $DOTFILES/zsh/sotarok/.zshrc $HOME
ln -s $DOTFILES/zsh/sotarok/.dircolors $HOME
ln -s $DOTFILES/zsh/sotarok/.zshrc.d $HOME
ln -s $DOTFILES/screen/sotarok/.screenrc $HOME
ln -s $DOTFILES/misc/sotarok/.my.cnf $HOME
ln -s $DOTFILES/misc/sotarok/.gitconfig $HOME
touch $HOME/.outputz

if test ! -d $HOME/bin
then
    mkdir $HOME/bin
fi

ln -s $DOTFILES/bin/sotarok/* $HOME/bin
