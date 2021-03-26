#!/bin/bash

###############
# Name: docker compose install
# Author: Ztj
# Email: ztj1993@gmail.com
# CreateDate: 2021-01-12
# UpdateDate: 2021-03-26
###############

set -e

version=${DOCKER_COMPOSE_VERSION:-1.28.5}
mirror=${GITHUB_MIRROR:-http://github.com}
uri=${mirror}/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)
curl -L --fail ${uri} -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
