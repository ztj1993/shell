#!/bin/bash

###############
# Name: ubuntu 163 mirror
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2021-01-12
# UpdateDate: 2021-03-26
###############

set -e

cp /etc/apt/sources.list /etc/apt/sources.list.backup.$(date +%Y-%m-%d-%H-%M-%S)

search="http://[a-z0-9\.]*/ubuntu"
replace="http://mirrors.163.com/ubuntu"
sed -i "s@${search}@${replace}@g" /etc/apt/sources.list

# 更新系统
apt -y update
