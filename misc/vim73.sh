#!/bin/sh

test -d vim73 && rm -rf vim73

# download sources and extract
test -f vim-7.3.tar.bz2 || wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
#test -f vim-7.3-lang.tar.gz || wget ftp://ftp.vim.org/pub/vim/extra/vim-7.3-lang.tar.gz
tar xf vim-7.3.tar.bz2
#tar xf vim-7.3-lang.tar.gz

# download patches
cd vim73

ln -sf ../vim-patches
cat vim-patches/7.3.* | patch -p0

# setup
./configure --prefix=$HOME --enable-multibyte --enable-gpm --enable-cscope --with-features=huge --enable-fontset --disable-gui --without-x --disable-xim --enable-pythoninterp --enable-perlinterk \
    && make \
    && make install \
    && cd ../ \
    && rm -rf ./vim73 && rm vim*tar*
