#!/bin/bash

###############
# Name: docker deploy
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-18
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/docker-deploy.sh
#     chmod +x docker-deploy.sh
#     sudo ./docker-deploy.sh
###############

# 安装部署
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
curl -sSL http://t.cn/RQl5OwB | sh -s http://ef017c13.m.daocloud.io

# 开机启动
systemctl restart docker.service
systemctl enable docker.service

# 自定义网络
docker network create --subnet=172.100.0.0/16 admin_network

# 安装管理
docker run -d --name portainer \
  --net admin_network \
  --ip 172.100.0.2 \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  portainer/portainer
docker update --restart always portainer
