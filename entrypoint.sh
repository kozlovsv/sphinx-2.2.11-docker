#!/bin/bash

set -e

envsubst \
    '${DB_HOST} ${DB_NAME} ${DB_USERNAME} ${DB_PASSWORD}' \
    < /etc/sphinx/sphinx.conf.template \
    > /etc/sphinx/sphinx.conf

exec "$@"