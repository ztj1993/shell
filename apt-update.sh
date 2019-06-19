#!/bin/bash

###############
# Name: apt update
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-update.sh
#     chmod +x apt-update.sh
#     sudo ./apt-update.sh
###############

set -e
set -x

# 更新系统
search="[a-z0-9\.]*.ubuntu.com"
replace="mirrors.aliyun.com"
sudo sed -i "s/${search}/${replace}/g" /etc/apt/sources.list

sudo apt-get -y update
sudo apt-get -y upgrade
