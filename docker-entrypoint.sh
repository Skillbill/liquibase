#!/bin/bash

set -o pipefail
set -o errtrace
set -o nounset
set -o errexit

cp /drivers/*.jar ./lib

LIQUIBASE_OPTS="--defaultsFile=/liquibase.properties --logLevel=INFO --logFile=/usr/src/myapp/liquibase.log"

echo -n > /liquibase.properties

if [[ -d "./changeset" ]]; then
    LIQUIBASE_OPTS="$LIQUIBASE_OPTS --changeLogFile=./changeset/liquibase.yml"
else
    LIQUIBASE_OPTS="$LIQUIBASE_OPTS --changeLogFile=/liquibase.yml"
fi

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

echo "LIQUIBASE_OPTS: $LIQUIBASE_OPTS"

./liquibase $LIQUIBASE_OPTS "$@"


echo "log: "
cat liquibase.log
