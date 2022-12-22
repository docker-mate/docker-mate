#!/usr/bin/env bash

composer create-project shopware/production:dev-flex app --no-interaction

cd app || exit
sed -i -e "s%APP_URL=.*%APP_URL=https://${PROJECT_NAME}.docker%g" .env
sed -i -e "s%STOREFRONT_PROXY_URL=.*%STOREFRONT_PROXY_URL=https://${PROJECT_NAME}.docker%g" .env
sed -i -e "s%DATABASE_URL=.*%DATABASE_URL=mysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:3306/${DB_NAME}%g" .env
