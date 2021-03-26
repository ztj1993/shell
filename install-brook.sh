#!/bin/bash

###############
# Name: install brook
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2021-01-12
# UpdateDate: 2021-03-26
###############

set -e

version=${BROOK_VERSION:-20210214}
mirror=${GITHUB_MIRROR:-http://github.com}
uri=${mirror}/txthinking/brook/releases/download/v${version}/brook_linux_amd64
curl -L --fail ${uri} -o /usr/local/bin/brook
chmod +x /usr/local/bin/brook
brook --version
