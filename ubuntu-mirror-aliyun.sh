#!/bin/bash

###############
# Name: apt aliyun mirror
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2019-06-19
# UpdateDate: 2021-03-26
###############

set -e

cp /etc/apt/sources.list /etc/apt/sources.list.backup.$(date +%Y-%m-%d-%H-%M-%S)

search="http://[a-z0-9\.]*/ubuntu"
replace="http://mirrors.aliyun.com/ubuntu"
sed -i "s@${search}@${replace}@g" /etc/apt/sources.list

apt -y update
