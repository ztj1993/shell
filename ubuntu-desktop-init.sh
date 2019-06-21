#!/bin/bash

###############
# Name: ubuntu desktop init
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-21
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/ubuntu-desktop-init.sh
#     chmod +x ubuntu-desktop-init.sh
#     ./ubuntu-desktop-init.sh
###############

set -e
set -x

# 免密码
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)

# 关闭盖子不休眠
sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# 基础库
sudo apt-get install -y libssl-dev libcurl4-openssl-dev

# 基础软件
sudo apt-get install -y curl wget git vim htop terminator

# Python
curl -sSL https://dwz.cn/imrR3eVN | sudo sh

# GoLang
sudo apt-get install -y golang

# PHP
sudo apt-get install -y php7.2-cli

sudo wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer

sudo wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
sudo chmod +x /usr/local/bin/phpunit

# C/C++
sudo apt-get install -y build-essential
