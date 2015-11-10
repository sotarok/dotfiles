#!/bin/bash

sudo apt-get -y update
sudo apt-get install -y software-properties-common curl vim python-pip python-dev build-essential python-apt
sudo pip install ansible markupsafe

ansible-playbook -i "localhost," -c local playbook.yml
