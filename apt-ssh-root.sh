#!/bin/bash

###############
# Name: apt ssh allow root login
# Author: Ztj
# Email: ztj1993@gmail.com
# Date: 2019-09-06
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/apt-ssh-root.sh
#     chmod +x ./apt-ssh-root.sh
#     sudo ./apt-ssh-root.sh
###############

set -e

apt-get install -y openssh-server

sed -i "s@^#PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sed -i "s@^PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sed -i "s@^PasswordAuthentication.*@PasswordAuthentication yes@" /etc/ssh/sshd_config

[[ ! -f /etc/ssh/ssh_host_rsa_key ]] && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server

/etc/init.d/ssh restart
