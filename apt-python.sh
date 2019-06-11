#!/bin/bash

###############
# Name: apt install python2 and python3
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-11
# Version: 1.0.0
# Use: curl -sSL https://dwz.cn/imrR3eVN | sh
###############

set -e
set -x

apt-get install -y wget

rm -rf get-pip.py
wget https://bootstrap.pypa.io/get-pip.py

apt-get install -y libssl-dev libcurl4-openssl-dev

apt-get install -y python-pip python-dev
python get-pip.py
pip install virtualenv

apt-get install -y python3-pip python3-dev
python3 get-pip.py
pip3 install virtualenv
