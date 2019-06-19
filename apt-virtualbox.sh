#!/bin/bash

###############
# Name: apt install virtualbox
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-virtualbox.sh
#     chmod +x apt-virtualbox.sh
#     sudo ./apt-virtualbox.sh
#     --- or ---
#     curl -sSL https://dwz.cn/gh4NlNLr | sudo sh
###############

set -e
set -x

deb_source="deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
deb_file="/etc/apt/sources.list.d/virtualbox.list"
echo ${deb_source} | tee ${deb_file}

rm -rf oracle_vbox_2016.asc
wget http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc
apt-key add oracle_vbox_2016.asc
rm -rf oracle_vbox_2016.asc

rm -rf oracle_vbox.asc
wget http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
apt-key add oracle_vbox.asc
rm -rf oracle_vbox.asc

apt-get update
apt-get install -y virtualbox-6.0

rm -rf ${deb_file}
