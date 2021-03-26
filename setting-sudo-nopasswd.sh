#!/bin/bash

###############
# Name: 用户免密码
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2021-01-12
# UpdateDate: 2021-01-12
###############

# 用户免密码
echo "$(whoami) ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)
