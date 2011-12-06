#!/bin/sh

##
# before run this script, setup followings
# - install ssh server
#  - sudo aptitude -y install openssh-server
#
# before run this script, check following settings
# - which php version to install
#  - check source.list
#
# @author   sotarok
##

# add dotdeb sources to aptitude, and upgrade all
#cp /etc/apt/sources.list ~/sources.list.tmp
#echo "deb http://packages.dotdeb.org stable all
#deb-src http://packages.dotdeb.org stable all" >> ~/sources.list.tmp
#echo "deb http://php53.dotdeb.org stable all
#deb-src http://php53.dotdeb.org stable all" >> ~/sources.list.tmp
#sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
#sudo cp ~/sources.list.tmp /etc/apt/sources.list
##
sudo apt-get -y update
sudo apt-get -y upgrade

###install git
sudo apt-get -y install git git-svn git-doc screen curl zsh
sudo apt-get -y install strace gdb libgdb-dev valgrind

###install developers environmnet
sudo apt-get -y install build-essential linux-headers-`uname -r` autoconf
# debug tools
#sudo apt-get -y install boost-build libboost-dev
#
###install apache
#sudo aptitude -y install apache2 apache2-dev
#
###install php (from dotdeb)
##sudo aptitude -y install php5 php5-cli php5-common php5-curl php5-gd php5-json php5-mcrypt php5-mysql php5-pgsql php5-sqlite
##sudo aptitude -y install php5-dev
##sudo aptitude install php-pear

###
##configure apache
#sudo mkdir -p /var/local/www/html
#echo "
#<Directory *>
#    Options Indexes Includes MultiViews ExecCGI FollowSymLinks
#    AllowOverride All
#</Directory>
#
#<VirtualHost *:80>
#	ServerAdmin webmaster@localhost
#	DocumentRoot /var/local/www/html
#	ErrorLog /var/log/apache2/error.log
#	# Possible values include: debug, info, notice, warn, error, crit,
#	# alert, emerg.
#	LogLevel warn
#
#	CustomLog /var/log/apache2/access.log combined
#</VirtualHost>
#
#<Location /server-status>
#SetHandler server-status
#Order Deny,Allow
#Deny from all
#Allow from 127.0.0.1
#Allow from localhost
#</Location>
#
#ExtendedStatus On
#
#" > ~/apache-sotarok
#sudo mv ~/apache-sotarok /etc/apache2/sites-available/apache-sotarok
#sudo a2dissite default
#sudo a2ensite apache-sotarok
#sudo service apache2 reload
#sudo chown -R sotarok:sotarok /var/local/www
#echo "It's Work! -- sotarok" > /var/local/www/html/index.html
#echo "<?php phpinfo(); " > /var/local/www/html/info.php
#ln -s /var/local/www ~/localwww

