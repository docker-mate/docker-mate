#!/usr/bin/env bash

bash .docker-mate/utils/message.sh headline "This script will help you to setup a git repo with a .gitignore"

ADD_GIT=y

if [[ ! $NEW_PROJECT_GIT ]]; then
    read -e -r -p "Add git to app folder? [y/n]:" ADD_GIT
else
    ADD_GIT=$NEW_PROJECT_GIT
fi

if [[ ${ADD_GIT} =~ ^[Yy] ]]; then
    if [[ -f ".docker-mate/systems/${PROJECT_TYPE}/.gitignore" ]]; then
        cp .docker-mate/systems/"${PROJECT_TYPE}"/.gitignore app/
    fi

    read -e -r -p "Enter origin url: " REPOSITORY

    cd app || exit
    rm -rf .git
    git init
    git add .
    git commit -q -m '[TASK] Initial commit'
    git checkout -b develop

    if [[ -n "${REPOSITORY}" ]]; then
        git remote add origin "${REPOSITORY}"
        git push origin --all -f
        git push -u origin develop
    fi

    cd ..
fi
