#!/bin/bash

###############
# Name: create mysql user
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-07-02
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/mysql-user.sh
#     chmod +x mysql-user.sh
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/mysql-sql.sh
#     chmod +x mysql-sql.sh
#     ./mysql-user.sh
###############

quiet=${quiet}
user_host=${user_host:-localhost}
user_name=${user_name:-test}
user_pwd=${user_pwd:-test}

if [[ -z ${quiet} ]]; then
    read -p ">>> Please enter the user host (default: ${user_host}): " read_user_host
    [[ -n ${read_user_host} ]] && user_host=${read_user_host}
    read -p ">>> Please enter the user name (default: ${user_name}): " read_user_name
    [[ -n ${read_user_name} ]] && user_name=${read_user_name}
    read -p ">>> Please enter the user password (default: ${user_pwd}): " read_user_pwd
    [[ -n ${read_user_pwd} ]] && user_pwd=${read_user_pwd}
fi


sql_file=$(mktemp /tmp/sql.XXX)

echo "
CREATE USER IF NOT EXISTS \`${user_name}\`@\`${user_host}\` IDENTIFIED BY '${user_pwd}';
CREATE DATABASE IF NOT EXISTS \`${user_name}\`;
GRANT ALL PRIVILEGES ON \`${user_name}\`.* TO \`${user_name}\`@\`${user_host}\`;
GRANT ALL PRIVILEGES ON \`${user_name}\_%\`.* TO \`${user_name}\`@\`${user_host}\`;
" | tee ${sql_file}

source mysql-sql.sh ${sql_file}
