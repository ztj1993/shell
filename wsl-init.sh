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
sudo apt-get install -y php7.2-mbstring
sudo apt-get install -y php7.2-curl
sudo apt-get install -y php7.2-gd
sudo apt-get install -y php7.2-zip

sudo wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer
sudo wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
sudo chmod +x /usr/local/bin/phpunit
sudo wget -O /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
sudo chmod +x /usr/local/bin/phpcs
sudo wget -O /usr/local/bin/phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
sudo chmod +x /usr/local/bin/phpcbf
sudo wget -O /usr/local/bin/php-cs-fixer https://cs.symfony.com/download/php-cs-fixer-v2.phar
sudo chmod +x /usr/local/bin/php-cs-fixer

# C/C++
sudo apt-get install -y build-essential

# Web
echo 'mysql-server-5.7 mysql-server/root_password password root' | sudo debconf-set-selections
echo 'mysql-server-5.7 mysql-server/root_password_again password root' | sudo debconf-set-selections

sudo apt-get install -y apache2
sudo apt-get install -y nginx
sudo apt-get install -y mysql-server-5.7
sudo apt-get install -y redis-server

sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
sudo a2enmod rewrite

grep "^AcceptFilter http none" /etc/apache2/apache2.conf > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "AcceptFilter http none" | sudo tee -a /etc/apache2/apache2.conf
grep "^AcceptFilter https none" /etc/apache2/apache2.conf > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "AcceptFilter https none" | sudo tee -a /etc/apache2/apache2.conf

sudo usermod -d /var/lib/mysql/ mysql
