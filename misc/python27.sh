#!/bin/sh

VERSION="2.7"
test -f Python-${VERSION}.tar.bz2 || wget http://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tar.bz2
tar jxvf Python-${VERSION}.tar.bz2
cd Python-${VERSION} && ./configure && make && sudo make install && cd ..

wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
rm ez_setup.py

sudo easy_install yolk yolk-portage
sudo easy_install ipython
