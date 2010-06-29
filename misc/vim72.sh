#!/bin/sh

# download sources and extract
test -f vim-7.2.tar.bz2 || wget ftp://ftp.vim.org/pub/vim/unix/vim-7.2.tar.bz2
test -f vim-7.2-lang.tar.gz || wget ftp://ftp.vim.org/pub/vim/extra/vim-7.2-lang.tar.gz
bzip2 -dc vim-7.2.tar.bz2 | tar xvf -
tar zxvf vim-7.2-lang.tar.gz

# download patches
cd vim72/src
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
./configure --prefix=$HOME --enable-multibyte --enable-gpm --enable-cscope --with-features=huge --enable-fontset --disable-gui --without-x --disable-xim --enable-pythoninterp --enable-perlinterp && make && make install && cd ../../ && rm -rf ./vim72 && rm vim*tar*
