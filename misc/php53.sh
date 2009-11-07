#!/bin/sh

## memo:
## required by openid lib -> bcmath gmp

## For debian
## mcrypt   : libmcrypt-dev
## t1lib    : libt1-dev
## imap     : libc-client-dev (U8T_CANONICAL error)
## xslt     : libxslt-dev (U8T_CANONICAL error)
## curl(ssl): libcurl2-openssl-dev (U8T_CANONICAL error)
## bzip2    : libbz2-dev
## gmp      : libgmp3-dev
## gd       : libgd2-xpm-dev
## readline : libreadline5-dev


#wget http://jp2.php.net/get/php-5.3.0.tar.gz/from/jp.php.net/mirror
#tar zxvf php-5.3.0.tar.gz
#cd php-5.3.0
#./configure \
#  --with-config-file-path=/etc/php \
#  --with-config-file-scan-dir=/etc/php/conf.d \
#  --with-apxs2=/usr/bin/apxs2 \
#  --with-pcre-regex=/usr \
#  --with-openssl \
#  --with-zlib \
#  --with-bz2 \
#  --with-curl \
#  --enable-exif \
#  --with-pcre-dir \
#  --enable-ftp \
#  --with-openssl-dir \
#  --with-gd \
#   --with-jpeg-dir \
#   --with-png-dir \
#   --with-xpm-dir \
#   --with-freetype-dir \
#   --with-t1lib \
#  --with-gettext \
#  --with-mhash \
#  --with-imap \
#   --with-kerberos \
#   --with-imap-ssl \
#  --enable-mbstring \
#  --with-mcrypt \
#  --with-mysql \
#  --with-mysqli \
#  --with-pdo-mysql \
#  --with-pdo-pgsql \
#  --with-pgsql \
#  --with-readline \
#  --enable-soap \
#  --enable-sockets \
#  --enable-sqlite-utf8 \
#  --with-xsl \
#  --enable-zip \
#  --with-pear \
#  --with-tidy \
#  --enable-zend-multibyte \
#  --enable-sysvsem \
#  --enable-sysvshm \
#  --enable-sysvmsg \
#  --enable-bcmath \
#  --with-gmp \
#  --enable-pcntl
#make && sudo make install

## optional
#sudo mkdir -p /etc/php/conf.d
#sudo cp php.ini-development /etc/php/php.ini

#sudo pear channel-update pear.php.net
#sudo pear channel-discover pear.ethna.jp
#sudo pear channel-discover openpear.org
#sudo pear channel-discover pear.symfony-project.com
#
#sudo pear upgrade-all
#sudo pear install http_request2-alpha
sudo pear install openpear/phpman-beta
sudo pear run-scripts openpear/phpman

#sudo pear install -a ethna/ethna
#
#sudo pecl install xdebug
#echo "zend_extension="`php -i | grep '^extension_dir' | cut -f5 -d" " `"/xdebug.so" > ~/xdebug.ini
#sudo mv ~/xdebug.ini /etc/php/conf.d/xdebug.ini
#sudo pecl install apc
#echo "extension=apc.so" > ~/apc.ini
#sudo mv ~/apc.ini /etc/php/conf.d/apc.ini
