#!/usr/bin/env bash

composer create-project shopware/composer-project app/web --stability=dev --no-interaction

cd app/web || exit
cp .env.example .env
sed -i -e "s%composer.test/path%${PROJECT_NAME}.docker%g" .env
sed -i -e "s%DATABASE_URL=.*%DATABASE_URL=mysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:3306/${DB_NAME}%g" .env
