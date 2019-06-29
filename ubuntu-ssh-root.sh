#!/bin/bash

###############
# Name: ubuntu ssh root login
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/ubuntu-ssh-root.sh
#     chmod +x ./ubuntu-ssh-root.sh
#     sudo ./ubuntu-ssh-root.sh
###############

sed -i "s@^#PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sed -i "s@^PermitRootLogin.*@PermitRootLogin yes@" /etc/ssh/sshd_config
sed -i "s@^PasswordAuthentication.*@PasswordAuthentication yes@" /etc/ssh/sshd_config

DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server

/etc/init.d/ssh restart
