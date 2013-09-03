#!/bin/sh


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
ln -sf $DOTFILES/zsh/.zshrc $HOME
ln -sf $DOTFILES/zsh/.dircolors $HOME
ln -snf $DOTFILES/zsh/.zshrc.d $HOME
ln -sf $DOTFILES/screen/.screenrc $HOME
ln -sf $DOTFILES/tmux/.tmux.conf $HOME
ln -sf $DOTFILES/misc/.my.cnf $HOME
ln -sf $DOTFILES/misc/.gitconfig $HOME
ln -sf $DOTFILES/misc/.gitignore $HOME
ln -sf $DOTFILES/misc/.globalrc $HOME
ln -snf $DOTFILES/mocksmtpd/ $HOME/.mocksmtpd

test ! -d $HOME/bin && mkdir $HOME/bin

cat $DOTFILES/ssh/authorized_keys | sort | uniq > $HOME/authorized_keys_merged
test ! -d $HOME/.ssh && mkdir $HOME/.ssh && chmod 700 $HOME/.ssh
test -f $HOME/.ssh/authorized_keys && cat $HOME/.ssh/authorized_keys >> $HOME/.ssh/authorized_keys_merged
test -f $HOME/.ssh/authorized_keys && mv $HOME/.ssh/authorized_keys $HOME/.ssh/authorized_keys.orig
mv $HOME/authorized_keys_merged $HOME/.ssh/authorized_keys && chmod 600 $HOME/.ssh/authorized_keys

test -f $HOME/.ssh/id_rsa.pub && mv $HOME/.ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub.orig
cp $DOTFILES/ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub && chmod 600 $HOME/.ssh/id_rsa.pub

ln -sf $DOTFILES/bin/* $HOME/bin

test ! -x $HOME/bin/tig \
    && cd $HOME \
    && git clone git://github.com/jonas/tig.git ./__tig \
    && cd __tig \
    && make install \
    && cd .. \
    && rm -rf __tig


cd $DOTFILES
git submodule update --init

