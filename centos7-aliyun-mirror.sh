#!/bin/bash

###############
# Name: centos7 setting aliyun mirror
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-08-31
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/centos7-aliyun-mirror.sh
#     chmod +x centos7-aliyun-mirror.sh
#     ./centos7-aliyun-mirror.sh
###############

set -e

os_version=$(cat /etc/os-release | grep VERSION_ID | cut -d '"' -f 2 |  awk -F'.' '{ print $1 }')
[[ "${os_version}" != "7" ]] && echo ">>> Error: os not is centos7." && exit 1

date_time=$(date +%Y-%m-%d-%H-%M-%S)
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup.${date_time}
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum makecache
