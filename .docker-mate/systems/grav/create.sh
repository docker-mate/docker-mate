#!/usr/bin/env bash

composer create-project getgrav/grav app/web --ignore-platform-reqs

cd app/web || exit
./bin/gpm install admin -y
./bin/grav clean

rm .gitignore

cd ../../
