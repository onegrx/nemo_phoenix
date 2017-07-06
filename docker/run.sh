#!/bin/bash

SYSCONFIG="${RELEASE_PATH}/releases/*/sys.config"
NEMO_HOSTNAME="${NEMO_HOSTNAME:-$(hostname)}"
SECRET="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"

#setup nemo
sed -i -e "s/__NEMO_PSQL_USER__/${NEMO_PSQL_USER}/" ${SYSCONFIG}
sed -i -e "s/__NEMO_PSQL_PASSWORD__/${NEMO_PSQL_PASSWORD}/" ${SYSCONFIG}
sed -i -e "s/__NEMO_PSQL_HOST__/${NEMO_PSQL_HOST}/" ${SYSCONFIG}
sed -i -e "s/__SECRET__/${SECRET}/" ${SYSCONFIG}

#migrate db
${RELEASE_PATH}/bin/nemo command 'Elixir.Nemo.Release.Task' migrate
${RELEASE_PATH}/bin/nemo foreground

