#!/bin/bash

###############
# Name: linux amd64 install docopts
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-23
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/amd64-docopts.sh
#     chmod +x amd64-docopts.sh
#     sudo ./amd64-docopts.sh
#     --- or ---
#     curl -sSL https://raw.githubusercontent.com/ztj1993/shell/master/amd64-docopts.sh | sudo sh
###############

set -e
set -x

wget -O /usr/local/bin/docopts https://github.com/docopt/docopts/releases/download/v0.6.3-alpha1/docopts
chmod +x /usr/local/bin/docopts
docopts --version
