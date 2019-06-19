#!/bin/bash

###############
# Name: snap work env
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/snap-work.sh
#     chmod +x snap-work.sh
#     ./snap-work.sh
###############

set -e
set -x

snap install redis-desktop-manager
snap install postman
snap install ao
snap install filezilla --beta
snap install chromium
