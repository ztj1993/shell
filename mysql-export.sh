#!/bin/bash

###############
# Name: export mysql database
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-07-01
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/mysql-export.sh
#     chmod +x mysql-export.sh
#     ./mysql-export.sh
###############

file_path=${1}
quiet=${quiet}
db_host=${db_host:-localhost}
db_port=${db_port:-3306}
db_user=${db_user:-root}
db_pwd=${db_pwd}
db_name=${db_name}

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
    [[ -z ${db_name} ]] && read -p ">>> Please enter the db name (default: all): " read_db_name
    [[ -n ${db_name} ]] && read -p ">>> Please enter the db name (default: ${db_name}): " read_db_name
    [[ -n ${read_db_name} ]] && db_name=${read_db_name}
    [[ -z ${file_path} ]] && read -p ">>> Please enter the sql file path: " read_file_path
    [[ -n ${file_path} ]] && read -p ">>> Please enter the sql file path (default: ${file_path}): " read_file_path
    [[ -n ${read_file_path} ]] && file_path=${read_file_path}
fi

datetime=`date +%Y-%m-%d-%H-%M-%S`

if [[ -z ${db_name} ]]; then
    mysqldump --host=${db_host} --port=${db_port} \
        --user=${db_user} --password=${db_pwd} \
        --all-databases | gzip > ${file_path}/mysql.all.${datetime}.sql.gz
else
    mysqldump --host=${db_host} --port=${db_port} \
        --user=${db_user} --password=${db_pwd} \
        ${db_name} | gzip > ${file_path}/mysql.${db_name}.${datetime}.sql.gz
fi
