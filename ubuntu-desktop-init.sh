#!/bin/bash

###############
# Name: ubuntu desktop init
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-13
###############


set -e
set -x

###### 系统配置
# 免密码
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$(whoami)

# 关闭盖子不休眠
sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

###### 更新系统
search="[a-z0-9\.]*.ubuntu.com"
replace="mirrors.aliyun.com"
sed -i "s/${search}/${replace}/g" /etc/apt/sources.list

apt-get -y update
apt-get -y upgrade

###### 基础库
apt-get install -y libssl-dev libcurl4-openssl-dev

###### 基础软件
apt-get install -y curl wget vim htop terminator proxychains4

###### 常用软件
apt-get install -y

###### 开发环境
# Python
curl -sSL https://dwz.cn/imrR3eVN | sh

# GoLang
apt-get install -y golang

# PHP
apt-get install -y php7.2-cli

wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
chmod +x /usr/local/bin/composer

wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
chmod +x /usr/local/bin/phpunit

# C/C++
apt-get install -y build-essential


###### Docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
curl -sSL http://t.cn/RQl5OwB | sh -s http://ef017c13.m.daocloud.io

systemctl restart docker.service
systemctl enable docker.service

docker run -d --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
docker update --restart always portainer

###### Wine
apt-get install -y wine-development

###### VirtualBox
curl -sSL https://dwz.cn/gh4NlNLr | sh
