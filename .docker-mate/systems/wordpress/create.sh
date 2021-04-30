#!/usr/bin/env bash

grep -v '^#' .env | xargs -d '\n' &>/dev/null

composer create-project roots/bedrock app

sed -i -e "s/database_name/${DB_NAME}/g" app/.env
sed -i -e "s/database_user/${DB_USER}/g" app/.env
sed -i -e "s/database_password/${DB_PASSWORD}/g" app/.env
sed -i -e "s/# DB_HOST=localhost/DB_HOST=${DB_HOST}/g" app/.env
sed -i -e "s/# DB_PREFIX=wp_/DB_PREFIX=${DB_PREFIX}/g" app/.env
sed -i -e "s/:\/\/example.com/s:\/\/${PROJECT_NAME}.docker/g" app/.env
