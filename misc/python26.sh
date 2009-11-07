#!/bin/sh

wget http://www.python.org/ftp/python/2.6.3/Python-2.6.3.tgz
tar zxvf Python-2.6.3.tgz
cd Python-2.6.3 && ./configure && make && sudo make install && cd ..

wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
rm ez_setup.py

sudo easy_install yolk yolk-portage
sudo easy_install ipython
