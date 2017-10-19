#!/bin/bash
set -eo pipefail
shopt -s nullglob
DATADIR="/opt/solr-4.10.4/example/solr/collection1/data"

# if command starts with an option, prepend java
if [ "${1:0:1}" = '-' ]; then
	set -- java "$@"
fi

if [ ! -d "${DATADIR}" ]; then
  if [ -d "/docker-entrypoint-initdb.d/data/" ]; then
    echo "${0}: Copy default data to ${DATADIR}";
    rm -rf ${DATADIR}
    cp -R /docker-entrypoint-initdb.d/data/ ${DATADIR}
    echo
  fi
fi

exec "$@"