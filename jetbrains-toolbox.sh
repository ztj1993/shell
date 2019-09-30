#!/bin/bash

###############
# Name: jetbrains toolbox install
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-09-30
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/jetbrains-toolbox.sh
#     chmod +x jetbrains-toolbox.sh
#     sudo ./jetbrains-toolbox.sh
###############

set -e

which jetbrains-toolbox && echo "Jetbrains Toolbox already installed!" && exit 0

rm -rf jetbrains-toolbox.tar.gz
url="https://data.services.jetbrains.com/products/download?code=TBA&platform=linux"
wget -O jetbrains-toolbox.tar.gz ${url}

tar -xzvf jetbrains-toolbox.tar.gz --strip-components 1 -C /tmp
mv /tmp/jetbrains-toolbox /usr/bin/jetbrains-toolbox
chmod +x /usr/bin/jetbrains-toolbox

rm -rf jetbrains-toolbox.tar.gz

jetbrains-toolbox
