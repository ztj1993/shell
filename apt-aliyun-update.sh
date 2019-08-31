#!/bin/bash

###############
# Name: apt aliyun update
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-aliyun-update.sh
#     chmod +x apt-aliyun-update.sh
#     sudo ./apt-aliyun-update.sh
###############

set -e

# 更新系统
search="[a-z0-9\.]*.ubuntu.com"
replace="mirrors.aliyun.com"
sed -i "s/${search}/${replace}/g" /etc/apt/sources.list

apt-get -y update
apt-get -y upgrade
apt-get -y clean
