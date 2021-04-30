#!/usr/bin/env bash

mkdir -p app/web
cd app/web || exit

curl -iL -o shopware.zip "$(curl -s https://www.shopware.com/en/download/ | grep -ioEm 1 "https:\/\/www\.shopware\.com\/en\/Download\/redirect\/version\/sw5\/file\/install_5\.[0-9]\.[0-9]{1,2}_[0-9a-f]{40}\.zip")"

unzip shopware.zip
rm shopware.zip
