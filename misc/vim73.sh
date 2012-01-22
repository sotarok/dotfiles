#!/bin/sh

# download sources and extract
test -f vim-7.3.tar.bz2 || wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
#test -f vim-7.3-lang.tar.gz || wget ftp://ftp.vim.org/pub/vim/extra/vim-7.3-lang.tar.gz
tar xf vim-7.3.tar.bz2
#tar xf vim-7.3-lang.tar.gz

# download patches
cd vim73
#wget http://ftp.vim.org/pub/vim/patches/7.2/7.2.001-100.gz
#wget http://ftp.vim.org/pub/vim/patches/7.2/7.2.101-200.gz
#gzip -d 7.2.001-100.gz
#gzip -d 7.2.101-200.gz
#wget http://ftp.vim.org/pub/vim/patches/7.2/7.2.{201..267}
#
#patch -p3 < src/7.2.001-100
#patch -p3 < src/7.2.101-200
#for fn in src/7.2.2* ; do patch -p3 < $fn ; done

# setup
#cd ..
./configure --prefix=$HOME --enable-multibyte --enable-gpm --enable-cscope --with-features=huge --enable-fontset --disable-gui --without-x --disable-xim --enable-pythoninterp --enable-perlinterk \
    && make \
    && make install \
    && cd ../ \
    && rm -rf ./vim73 && rm vim*tar*
