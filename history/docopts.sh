#!/bin/bash

###############
# Name: linux amd64 install docopts
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-23
# Note: Support only 
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/docopts.sh
#     chmod +x docopts.sh
#     sudo ./docopts.sh
#     --- or ---
#     curl -sSL https://raw.githubusercontent.com/ztj1993/shell/master/docopts.sh | sudo sh
###############

set -e

skip_confirm=${1:-no}

[[ "${skip_confirm}" != "yes" ]] && read -p ">>> Please confirm the os is amd64(yes/no): " read_confirm
[[ "${skip_confirm}" != "yes" ]] && [[ "${read_confirm}" != "yes" ]] && echo ">>> Not confirmed." && exit 1

wget -O /usr/local/bin/docopts https://github.com/docopt/docopts/releases/download/v0.6.3-rc1/docopts_linux_amd64
chmod +x /usr/local/bin/docopts
/usr/local/bin/docopts --version
