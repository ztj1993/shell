#!/bin/bash

###############
# Name: socks to http
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2019-06-12
# UpdateDate: 2021-03-26
###############

alias=${1:-default}
data_dir=~/.socks_to_http
config_file=${data_dir}/${alias}.conf
socks_host=${socks_host:-127.0.0.1}
socks_port=${socks_port:-1080}
http_host=${http_host:-127.0.0.1}
http_port=${http_port:-8118}

type brook > /dev/null 2>&1
[[ $? -ne 0 ]] && echo "Please install brook." && exit 1

[[ -f ${config_file} ]] && echo ">>> source ${config_file}" && source ${config_file}
[[ ! -f ${config_file} ]] && alias=""

[[ -z ${alias} ]] && read -p ">>> Please enter the write alias: " write_alias
[[ -z ${alias} ]] && [[ -z ${write_alias} ]] && echo ">>> Please enter the write alias." && exit 1

[[ -z ${alias} ]] && read -p ">>> Please enter the socks host (default: ${socks_host}): " read_socks_host
[[ -n ${read_socks_host} ]] && socks_host=${read_socks_host}

[[ -z ${alias} ]] && read -p ">>> Please enter the socks port (default: ${socks_port}): " read_socks_port
[[ -n ${read_socks_port} ]] && socks_port=${read_socks_port}

[[ -z ${alias} ]] && read -p ">>> Please enter the http host (default: ${http_host}): " read_http_host
[[ -n ${read_http_host} ]] && http_host=${read_http_host}

[[ -z ${alias} ]] && read -p ">>> Please enter the http port (default: ${http_port}): " read_http_port
[[ -n ${read_http_port} ]] && http_host=${read_http_port}

[[ -n ${write_alias} ]] && mkdir -p ${data_dir}
[[ -n ${write_alias} ]] && config_file=${data_dir}/${write_alias}.conf
[[ -n ${write_alias} ]] && echo ">>> write ${config_file}"
[[ -n ${write_alias} ]] && echo "socks_host=${socks_host}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "socks_port=${socks_port}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "http_host=${http_host}" >> ${config_file}
[[ -n ${write_alias} ]] && echo "http_port=${http_port}" >> ${config_file}

brook socks5tohttp -l ${http_host}:${http_port} -s ${socks_host}:${socks_port}
