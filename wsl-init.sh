#!/bin/bash

###############
# Name: windows subsystem for linux init
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-24
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/wsl-init.sh
#     chmod +x wsl-init.sh
#     ./wsl-init.sh
###############

set -e
set -x

# 免密码
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)

# 基础库
sudo apt-get install -y libssl-dev libcurl4-openssl-dev

# 基础软件
sudo apt-get install -y curl wget git vim

# SSH
sudo apt-get install -y openssh-server
sudo sed -i "s@^#PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sudo sed -i "s@^PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sudo sed -i "s@^PasswordAuthentication.*@PasswordAuthentication yes@" /etc/ssh/sshd_config
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server

# Python
curl -sSL https://dwz.cn/imrR3eVN | sudo sh

# GoLang
sudo apt-get install -y golang

# PHP
sudo apt-get install -y php7.2
sudo apt-get install -y php7.2-fpm
sudo apt-get install -y php7.2-mysql
sudo apt-get install -y php7.2-bcmath
sudo apt-get install -y php7.2-dev

sudo wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer

sudo wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
sudo chmod +x /usr/local/bin/phpunit

# C/C++
sudo apt-get install -y build-essential

# Web
sudo apt-get install -y apache2
sudo apt-get install -y nginx
sudo apt-get install -y mysql-server-5.7
sudo apt-get install -y redis-server
