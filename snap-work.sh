#!/bin/bash

###############
# Name: apt install work env
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-11
# Version: 1.0.0
###############

set -e
set -x

snap install redis-desktop-manager
snap install phpstorm --classic
snap install pycharm-community --classic
snap install datagrip --classic
snap install goland --classic
snap install brook
snap install postman
snap install chromium
snap install filezilla --beta
