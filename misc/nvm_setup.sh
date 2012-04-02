#!/bin/bash

VERSION=$1
echo $VERSION
test -z "$VERSION" && exit

cd $HOME
if test ! -d ./.nvm
then
    git clone git://github.com/creationix/nvm.git ./.nvm
    source ./.nvm/nvm.sh \
        && nvm install v${VERSION} \
        && nvm use $VERSION \
        && nvm alias default $VERSION
fi

test ! -z "$(which node)" && curl http://npmjs.org/install.sh | sh
