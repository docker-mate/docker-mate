#!/usr/bin/env bash
bash .docker-mate/utils/message.sh headline "This script will help you to your existing project"

while [[ ${REPOSITORY} == '' ]]; do
    read -e -r -p "Enter origin url: " REPOSITORY
done

bash .docker-mate/utils/message.sh info "Load your project..."

git clone "${REPOSITORY}" app/

echo "${PROJECT_TYPE}"

if [[ -f ".docker-mate/systems/${PROJECT_TYPE}/hook/load.sh" ]]; then
    bash .docker-mate/utils/message.sh info "Running load system hook..."
    bash .docker-mate/systems/"${PROJECT_TYPE}"/hook/load.sh
fi

if [[ -f "app/.docker-mate/load-hook.sh" ]]; then
    bash .docker-mate/utils/message.sh info "Running load app hook..."
    bash ./app/.docker-mate/load-hook.sh
fi
