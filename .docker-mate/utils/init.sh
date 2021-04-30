#!/usr/bin/env bash
bash .docker-mate/utils/message.sh headline "This script will help you get started with your development setup"

if [[ -f ".env" ]]; then
    # app directory exists; asking user for permission to delete
    bash .docker-mate/utils/message.sh warning "Attention!"
    echo "It looks like you already have an environment in place"
    echo "This script is intended to help with initial setup."
    echo "This can cause problems accessing the current setup"
    echo ""
    read -e -r -p "Do you want to generate a new .env file? [N/y]: " initOK
else
    initOK="y"
fi

if [[ ${initOK} =~ ^[Yy] ]]; then
    rm -rf app
    printf "Please select project type:\n"
    if [[ ! $NEW_PROJECT_TYPE ]]; then
        cd .docker-mate/systems || exit
        select NEW_PROJECT_TYPE in *; do
            test -n "$NEW_PROJECT_TYPE" && break
            echo ">>> Invalid number"
        done
        cd ../..
    fi
    export PROJECT_TYPE=${NEW_PROJECT_TYPE}

    if [[ ! $NEW_PROJECT_NAME ]]; then
        read -e -r -p "Project name/domain (valid domain)? [${NEW_PROJECT_TYPE}]:" NEW_PROJECT_NAME
        [[ -z "${NEW_PROJECT_NAME}" ]] && NEW_PROJECT_NAME=${NEW_PROJECT_TYPE}
    fi
    export PROJECT_NAME=${NEW_PROJECT_NAME}

    if [[ -f ".docker-mate/systems/${NEW_PROJECT_TYPE}/.env" ]]; then
        # shellcheck disable=SC1090
        source .docker-mate/systems/"${PROJECT_TYPE}"/.env
    fi

    # shellcheck disable=SC2016
    envsubst '${PROJECT_NAME} ${PROJECT_TYPE} ${URL_BACKEND} ${PHP_VERSION}' <.docker-mate/.env.example >.env
    bash .docker-mate/utils/message.sh info "Starting your project..."
fi
