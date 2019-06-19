#!/bin/bash

###############
# Name: ssh proxy
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/ssh-proxy.sh
#     chmod +x ./ssh-proxy.sh
#     sudo ./ssh-proxy.sh
###############

tmp_url=https://raw.githubusercontent.com/ztj1993/shell/master/ssh-to-socks.sh
wget -O /usr/local/bin/ssh-to-socks ${tmp_url}
chmod +x /usr/local/bin/ssh-to-socks

tmp_url=https://github.com/txthinking/brook/releases/download/v20190601/brook
wget -O /usr/local/bin/brook ${tmp_url}
chmod +x /usr/local/bin/brook

tmp_url=https://raw.githubusercontent.com/ztj1993/shell/master/socks-to-http.sh
wget -O /usr/local/bin/socks-to-http ${tmp_url}
chmod +x /usr/local/bin/socks-to-http
