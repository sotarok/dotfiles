#!/bin/sh

##
# install dependent libraries for PHP
#
#
# @author   sotarok
# @version  $Id
##

## db
sudo aptitude -y install sqlite3 libsqlite3-dev
sudo aptitude -y install postgresql-8.3 postgresql-server-dev-8.3
sudo aptitude -y install mysql-server-5.1

## For debian
sudo aptitude -y install libmcrypt-dev
sudo aptitude -y install libt1-dev
sudo aptitude -y install libc-client-dev
sudo aptitude -y install libxslt-dev
sudo aptitude -y install libcurl2-openssl-dev
sudo aptitude -y install libbz2-dev
sudo aptitude -y install libgmp3-dev
sudo aptitude -y install libgd2-xpm-dev
sudo aptitude -y install libreadline5-dev
sudo aptitude -y install libtidy-dev
