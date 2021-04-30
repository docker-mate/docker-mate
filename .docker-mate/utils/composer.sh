#!/usr/bin/env bash
if [[ -x "$(command -v composer)" ]]; then
    bash .docker-mate/utils/message.sh info "Using local composer"
    composer "$@" --working-dir=app --ignore-platform-reqs
else
    bash .docker-mate/utils/message.sh info "Using composer container - this can be very slow..."
    bash .docker-mate/utils/message.sh info "Please consider installing composer locally: https://getcomposer.org/download/"
    docker-compose run composer composer "$@"
fi
