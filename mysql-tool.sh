#!/bin/bash

###############
# Name: mysql tool
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-08-23
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/mysql-tool.sh
#     chmod +x mysql-tool.sh
#     ./mysql-tool.sh
###############

##?
##? This script is mysql tool
##?
##? Usage:
##?     mysql-tool
##?     mysql-tool --help
##?     mysql-tool --version
##?     mysql-tool install
##?     mysql-tool [options] import <sql_file>
##?     mysql-tool [options] export <sql_dir>
##?     mysql-tool [options] adduser <user_host> <user_name> <user_password>
##?     mysql-tool [options] passwd <user_host> <user_name> <user_password>
##?
##? Options:
##?     --help                   show help options.
##?     --version                print program version.
##?     --host=host              mysql server host [default: localhost]
##?     --port=port              mysql server port [default: 3306]
##?     --user=user              mysql admin user name [default: root]
##?     --password=password      mysql admin password
##?     --name=name              mysql database name [default: --all-databases]
##?
##? Arguments:
##?     sql_dir          sql dir path
##?     sql_file         sql file path
##?     user_host        mysql user host
##?     user_name        mysql user name
##?     user_password    mysql user password
##?
##? Actions:
##?     install       install self script
##?     import        import mysql sql zip, file=>mysql
##?     export        export mysql sql zip, mysql=>file
##?     adduser       add  new user
##?     passwd        modify user password
##?

set -e

type docopts > /dev/null 2>&1
[[ $? -ne 0 ]] && echo ">>> Please install https://github.com/docopt/docopts." && exit 1

help=$(grep "^##?" "$0" | cut -c 5-)
version=$(grep "^# LastDate"  "$0" | cut -c 3-)
eval "$(docopts -h "$help" -V "$version" : "$@")"

install=${install:-false}
import=${import:-false}
export=${export:-false}
adduser=${adduser:-false}
passwd=${passwd:-false}

host=${host:-localhost}
port=${port:-3306}
user=${user:-root}
password=${password}
name=${name:---all-databases}

sql_dir=${sql_dir}
sql_file=${sql_file}
user_host=${user_host}
user_name=${user_name}
user_password=${user_password}

datetime=$(date +%Y-%m-%d-%H-%M-%S)
mysql_params="--host=${host} --port=${port} --user=${user} --password=${password}"

if [[ ${install} == "true" ]]; then
    wget -O /usr/local/bin/mysql-tool https://raw.githubusercontent.com/ztj1993/shell/master/mysql-tool.sh
    chmod +x /usr/local/bin/mysql-tool
    /usr/local/bin/mysql-tool --version
fi

if [[ ${import} == "true" ]]; then
    mysql ${mysql_params} < ${sql_file}
fi

if [[ ${export} == "true" ]]; then
    mysqldump ${mysql_params} ${name} > ${sql_dir}/mysql.${name}.${datetime}.sql
fi

if [[ ${adduser} == "true" ]]; then
    tmp_file=$(mktemp /tmp/sql.XXX)
    echo "CREATE USER IF NOT EXISTS \`${user_name}\`@\`${user_host}\` IDENTIFIED BY '${user_password}';" >> ${tmp_file}
    echo "CREATE DATABASE IF NOT EXISTS \`${user_name}\`;" >> ${tmp_file}
    echo "GRANT ALL PRIVILEGES ON \`${user_name}\`.* TO \`${user_name}\`@\`${user_host}\`;" >> ${tmp_file}
    echo "GRANT ALL PRIVILEGES ON \`${user_name}\_%\`.* TO \`${user_name}\`@\`${user_host}\`;" >> ${tmp_file}
    mysql ${mysql_params} < ${tmp_file}
fi

if [[ ${passwd} == "true" ]]; then
    tmp_file=$(mktemp /tmp/sql.XXX)
    echo "ALTER USER IF EXISTS \`${user_name}\`@\`${user_host}\` IDENTIFIED BY '${user_password}';" >> ${tmp_file}
    mysql ${mysql_params} < ${tmp_file}
fi
