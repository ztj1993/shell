#!/bin/bash

###############
# Name: WSL Ubuntu 批处理
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2019-06-24
# UpdateDate: 2021-01-12
###############

# 用户免密码
./setting-sudo-nopasswd.sh

# 基础软件
sudo apt-get install -y curl wget git vim
