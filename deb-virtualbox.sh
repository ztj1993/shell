#!/bin/bash

###############
# Name: Debian/Ubuntu install VirtualBox
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-11
# Version: 1.0.0
###############

deb_source="deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
deb_file="/etc/apt/sources.list.d/virtualbox.list"
echo ${deb_source} >> ${deb_file}

apt-key add oracle_vbox_2016.asc
apt-key add oracle_vbox.asc

apt-get update
apt-get install virtualbox-6.0
