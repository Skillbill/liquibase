#!/bin/bash

set -o pipefail
set -o errtrace
set -o nounset
set -o errexit

cp /drivers/*.jar ./lib

env

LIQUIBASE_OPTS="--changeLogFile=/liquibase.yml --defaultsFile=/liquibase.properties"

echo -n > /liquibase.properties

if [[ -n "$LIQUIBASE_URL" ]]; then
    echo "url: ${LIQUIBASE_URL}" >> /liquibase.properties
fi

if [[ -n "$LIQUIBASE_USERNAME" ]]; then
    echo "username: ${LIQUIBASE_USERNAME}" >> /liquibase.properties
fi

if [[ -n "$LIQUIBASE_PASSWORD" ]]; then
    echo "password: ${LIQUIBASE_PASSWORD}" >> /liquibase.properties
fi

./waitdb $LIQUIBASE_OPTS

exec ./liquibase $LIQUIBASE_OPTS "$@"