#!/bin/bash

###############
# Name: windows subsystem for linux(ubuntu) init
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-24
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/wsl-ubuntu-init.sh
#     chmod +x wsl-ubuntu-init.sh
#     sudo ./wsl-ubuntu-init.sh
###############

set -e
set -x

# 免密码
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$(whoami)

# 基础软件
apt-get install -y curl wget git vim
