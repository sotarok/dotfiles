#!/bin/bash
# ref: http://www.mongodb.org/display/DOCS/Ubuntu+and+Debian+packages


sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

cat <<E >/tmp/mongo.list
deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen
E
sudo mv /tmp/mongo.list /etc/apt/sources.list.d/mongo.list

sudo apt-get update
sudo apt-get install mongodb-10gen

test -d /etc/munin \
    && wget -O erh-mongo-munin.tar.gz http://github.com/erh/mongo-munin/tarball/master \
    && tar xf erh-mongo-munin.tar.gz \
    && sudo cp erh-mongo-munin*/mongo_* /etc/munin/plugins/ \
    && sudo -u munin /usr/share/munin/munin-update \
    && rm -rf erh-mongo-munin*
