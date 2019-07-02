#!/bin/bash

###############
# Name: create mysql user
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-07-02
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/mysql-sql.sh
#     chmod +x mysql-sql.sh
#     ./mysql-sql.sh 'CREATE USER `temp`@`%` IDENTIFIED WITH mysql_native_password BY "temp";'
###############

sql=${sql:-${1}}
quiet=${quiet}
db_host=${db_host:-localhost}
db_port=${db_port:-3306}
db_user=${db_user:-root}
db_pwd=${db_pwd}

[[ -z ${sql} ]] && echo ">>> Error: sql cannot be empty." && exit 1

if [[ -z ${quiet} ]]; then
    read -p ">>> Please enter the db host (default: ${db_host}): " read_db_host
    [[ -n ${read_db_host} ]] && db_host=${read_db_host}
    read -p ">>> Please enter the db port (default: ${db_port}): " read_db_port
    [[ -n ${read_db_port} ]] && db_port=${read_db_port}
    read -p ">>> Please enter the db username (default: ${db_user}): " read_db_user
    [[ -n ${read_db_user} ]] && db_user=${read_db_user}
    [[ -z ${db_pwd} ]] && read -p ">>> Please enter the db password: " read_db_pwd
    [[ -n ${db_pwd} ]] && read -p ">>> Please enter the db password (default: ${db_pwd}): " read_db_pwd
    [[ -n ${read_db_pwd} ]] && db_pwd=${read_db_pwd}
fi

if [[ -f ${sql} ]]; then
    sql_file=${sql}
else
    sql_file=$(mktemp /tmp/sql.XXX)
    echo ${sql} > sql_file
fi

mysql --host=${db_host} --port=${db_port} \
    --user=${db_user} --password=${db_pwd} \
     < ${sql_file}

[[ $? -ne 0 ]] && echo ">>>>> Error: exec sql error." && exit 1
