#!/bin/bash

INSTALL_N_VERSION=$1
echo $INSTALL_N_VERSION
test -z "$INSTALL_N_VERSION" && exit

cd $HOME
if test ! -d $HOME/.nvm
then
    git clone git://github.com/creationix/nvm.git $HOME/.nvm
    source $HOME/.nvm/nvm.sh
    nvm install v${INSTALL_N_VERSION} \
        && nvm use $INSTALL_N_VERSION \
        && nvm alias default $INSTALL_N_VERSION
fi
