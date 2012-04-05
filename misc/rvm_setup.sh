#!/bin/bash

VERSION=$1
echo $VERSION
test -z "$VERSION" && exit

cd $HOME
if test ! -d ./.rvm
then
    bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    source "$HOME/.rvm/scripts/rvm" \
        && rvm install ${VERSION} \
        && rvm alias create default $VERSION \
        && rvm use $VERSION
fi
