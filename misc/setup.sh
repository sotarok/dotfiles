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

## zplug
if test ! -d $HOME/.zplug ; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

    test -f $HOME/.zsh/zplug.zsh && export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zsh"

    # load zplug
    source ~/.zplug/init.zsh

    if ! zplug check --verbose; then
        zplug install
    fi
    zplug load --verbose
fi

cd $DOTFILES
git submodule update --init
