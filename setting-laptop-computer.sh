#!/bin/bash

###############
# Name: 笔记本电脑配置
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2021-01-12
# UpdateDate: 2021-03-26
###############

# 关闭盖子不休眠
sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
