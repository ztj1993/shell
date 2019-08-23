#!/bin/bash

###############
# Name: hosts setting
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-08-23
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/hosts.sh
#     chmod +x hosts.sh
#     hosts.sh install
###############

##?
##? This script is used to set hosts
##?
##? Usage:
##?     hosts
##?     hosts --help
##?     hosts --version
##?     hosts install
##?     hosts add --host=<host> --ip=<ip>
##?     hosts del --host=<host>
##?
##? Options:
##?     --help        show help options.
##?     --version     print program version.
##?     --host=host   host
##?     --ip=ip       ip
##?
##? Actions:
##?     install       install self script
##?     add           add new host
##?     del           delete host
##?

set -e

type docopts > /dev/null 2>&1
[[ $? -ne 0 ]] && echo ">>> Please install https://github.com/docopt/docopts." && exit 1

help=$(grep "^##?" "$0" | cut -c 5-)
version=$(grep "^# LastDate"  "$0" | cut -c 3-)
eval "$(docopts -h "$help" -V "$version" : "$@")"

install=${install:-false}
add=${add:-false}
del=${del:-false}

host=${host:-localhost}
ip=${ip:-127.0.0.1}

if [[ ${install} == "true" ]]; then
    wget -O /usr/local/bin/hosts https://raw.githubusercontent.com/ztj1993/shell/master/hosts.sh
    chmod +x /usr/local/bin/hosts
    /usr/local/bin/hosts --version
fi

if [[ ${add} == "true" ]]; then
    cat /etc/hosts | grep "^${ip}\s*${host}" > /dev/null 2>&1
    [[ $? -eq 0 ]] && exit 0

    sed -i -e "s/^[0-9]\S*\s*${host}/# &/" /etc/hosts

    str=$(cat /etc/hosts | grep "^#\s*${ip}\s*${host}" | head -n 1)
    [[ -n "${str}" ]] && sed -i -e "/${str}/s/#\s*//" /etc/hosts && exit 0

    echo "${ip}   ${host}" | tee -a /etc/hosts
fi

if [[ ${del} == "true" ]]; then
    sed -i -e "s/^[0-9]\S*\s*${host}/# &/" /etc/hosts
fi
