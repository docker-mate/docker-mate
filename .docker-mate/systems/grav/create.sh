#!/usr/bin/env bash

composer create-project getgrav/grav app/web --no-interaction

cd app/web || exit
./bin/gpm install admin -y
./bin/grav clean

rm .gitignore

cd ../../
