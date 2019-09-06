#!/bin/bash

###############
# Name: apt install web env(nginx apache mysql php redis mongodb)
# Author: Ztj
# Email: ztj1993@gmail.com
# Date: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-web-dev.sh
#     chmod +x apt-web-dev.sh
#     sudo ./apt-web-dev.sh
###############

set -e
set -x

# setting mysql password: 123456
echo 'mysql-server-5.7 mysql-server/root_password password 123456' | debconf-set-selections
echo 'mysql-server-5.7 mysql-server/root_password_again password 123456' | debconf-set-selections

# install
apt-get install -y nginx
apt-get install -y apache2
apt-get install -y mysql-server-5.7
apt-get install -y mongodb

# install php
apt-get install -y php7.2
apt-get install -y php7.2-fpm
apt-get install -y php7.2-mysql
apt-get install -y php7.2-bcmath
apt-get install -y php7.2-dev
apt-get install -y php7.2-mbstring
apt-get install -y php7.2-curl
apt-get install -y php7.2-gd
apt-get install -y php7.2-zip

# install php packages
wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
chmod +x /usr/local/bin/composer
wget -O /usr/local/bin/phpunit http://phar.phpunit.cn/phpunit.phar
chmod +x /usr/local/bin/phpunit
wget -O /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x /usr/local/bin/phpcs
wget -O /usr/local/bin/phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
chmod +x /usr/local/bin/phpcbf
wget -O /usr/local/bin/php-cs-fixer https://cs.symfony.com/download/php-cs-fixer-v2.phar
chmod +x /usr/local/bin/php-cs-fixer

# setting
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
a2enmod rewrite

grep "^AcceptFilter http none" /etc/apache2/apache2.conf > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "AcceptFilter http none" | tee -a /etc/apache2/apache2.conf
grep "^AcceptFilter https none" /etc/apache2/apache2.conf > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "AcceptFilter https none" | tee -a /etc/apache2/apache2.conf

usermod -d /var/lib/mysql/ mysql

composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
