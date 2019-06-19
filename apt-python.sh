#!/bin/bash

###############
# Name: apt install python2 and python3
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-python.sh
#     chmod +x apt-python.sh
#     sudo ./apt-python.sh
#     --- or ---
#     curl -sSL https://dwz.cn/imrR3eVN | sudo sh
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

rm -rf get-pip.py
