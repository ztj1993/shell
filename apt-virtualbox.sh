#!/bin/bash

###############
# Name: apt install virtualbox
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-11
# Version: 1.0.0
# Use: curl -sSL https://dwz.cn/gh4NlNLr | sh
###############

set -e
set -x

deb_source="deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
deb_file="/etc/apt/sources.list.d/virtualbox.list"
echo ${deb_source} >> ${deb_file}

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

apt-get update
apt-get install -y virtualbox-6.0

rm -rf ${deb_file}
