#!/usr/bin/env bash

mkdir -p app

cd app || exit

curl -iL -o shopware.zip "$(curl -s https://www.shopware.com/en/download/ | grep -ioEm 1 "https:\/\/www\.shopware\.com\/en\/Download\/redirect\/version\/sw6\/file\/install_v?6\.[0-9\.]+\_[0-9a-f]+\.zip")"

unzip shopware.zip
rm shopware.zip
