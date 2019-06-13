#!/bin/bash

###############
# Name: ubuntu desktop init
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-13
###############


read -p ">>> Please enter the snap package path: " snap_pkg_path

set -e
set -x

export PATH=/snap/bin:${PATH}

###### 源处理
search="[a-z0-9\.]*.ubuntu.com"
replace="mirrors.aliyun.com"
sed -i "s/${search}/${replace}/g" /etc/apt/sources.list

###### 更新系统
apt-get -y update
apt-get -y upgrade

###### 基础库
apt-get install -y libssl-dev libcurl4-openssl-dev

###### 基础软件
apt-get install -y curl wget vim htop terminator proxychains4

###### Python
curl -sSL https://dwz.cn/imrR3eVN | sh

###### GoLang
apt-get install -y golang

###### PHP
apt-get install -y php7.2-cli

wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
chmod +x /usr/local/bin/composer

wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
chmod +x /usr/local/bin/phpunit

###### 工作环境
# snap install phpstorm --classic
if [ -f ${snap_pkg_path}/phpstorm.assert ] && [ -f ${snap_pkg_path}/phpstorm.snap ]; then
    echo ">>> snap install phpstorm"
    snap ack phpstorm.assert
    snap install phpstorm.snap --classic
else
    echo ">>> skip snap install phpstorm"
fi

# snap install pycharm-community --classic
if [ -f ${snap_pkg_path}/pycharm.assert ] && [ -f ${snap_pkg_path}/pycharm.snap ]; then
    echo ">>> snap install pycharm"
    snap ack pycharm.assert
    snap install pycharm.snap --classic
else
    echo ">>> skip snap install pycharm"
fi

# snap install datagrip --classic
if [ -f ${snap_pkg_path}/datagrip.assert ] && [ -f ${snap_pkg_path}/datagrip.snap ]; then
    echo ">>> snap install datagrip"
    snap ack datagrip.assert
    snap install datagrip.snap --classic
else
    echo ">>> skip snap install datagrip"
fi

# snap install goland --classic
if [ -f ${snap_pkg_path}/goland.assert ] && [ -f ${snap_pkg_path}/goland.snap ]; then
    echo ">>> snap install goland"
    snap ack goland.assert
    snap install goland.snap --classic
else
    echo ">>> skip snap install goland"
fi

# snap install intellij-idea-community --classic
if [ -f ${snap_pkg_path}/idea.assert ] && [ -f ${snap_pkg_path}/idea.snap ]; then
    echo ">>> snap install idea"
    snap ack idea.assert
    snap install idea.snap --classic
else
    echo ">>> skip snap install idea"
fi

# snap install clion --classic
if [ -f ${snap_pkg_path}/idea.assert ] && [ -f ${snap_pkg_path}/idea.snap ]; then
    echo ">>> snap install clion"
    snap ack clion.assert
    snap install clion.snap --classic
else
    echo ">>> skip snap install clion"
fi

# snap install redis-desktop-manager
if [ -f ${snap_pkg_path}/redis-desktop-manager.assert ] && [ -f ${snap_pkg_path}/redis-desktop-manager.snap ]; then
    echo ">>> snap install redis-desktop-manager"
    snap ack redis-desktop-manager.assert
    snap install redis-desktop-manager.snap
else
    echo ">>> skip snap install redis-desktop-manager"
fi

# snap install brook
if [ -f ${snap_pkg_path}/brook.assert ] && [ -f ${snap_pkg_path}/brook.snap ]; then
    echo ">>> snap install brook"
    snap ack brook.assert
    snap install brook.snap
else
    echo ">>> skip snap install brook"
fi

# snap install postman
if [ -f ${snap_pkg_path}/postman.assert ] && [ -f ${snap_pkg_path}/postman.snap ]; then
    echo ">>> snap install postman"
    snap ack postman.assert
    snap install postman.snap
else
    echo ">>> skip snap install postman"
fi

# snap install chromium
if [ -f ${snap_pkg_path}/chromium.assert ] && [ -f ${snap_pkg_path}/chromium.snap ]; then
    echo ">>> snap install chromium"
    snap ack chromium.assert
    snap install chromium.snap
else
    echo ">>> skip snap install chromium"
fi

# snap install filezilla --beta
if [ -f ${snap_pkg_path}/filezilla.assert ] && [ -f ${snap_pkg_path}/filezilla.snap ]; then
    echo ">>> snap install filezilla"
    snap ack filezilla.assert
    snap install filezilla.snap --beta
else
    echo ">>> skip snap install filezilla"
fi

# Docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
curl -sSL http://t.cn/RQl5OwB | sh -s http://ef017c13.m.daocloud.io

systemctl restart docker.service
systemctl enable docker.service

docker run -d --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
docker update --restart always portainer

# Wine
apt-get install -y wine-development

# VirtualBox
curl -sSL https://dwz.cn/gh4NlNLr | sh
