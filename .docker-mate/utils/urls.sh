#!/usr/bin/env bash

bash .docker-mate/utils/message.sh headline "You can access your project at the following URLS:"

URLS="Frontend,https://${MAIN_DOMAIN}/"

if [ -n "${URL_BACKEND}" ]; then
    URLS="${URLS} Backend,https://${MAIN_DOMAIN}/${URL_BACKEND}/"
fi

URLS="${URLS} Mailhog,https://mail.${PROJECT_NAME}.docker/"
URLS="${URLS} PHPMyAdmin,https://phpmyadmin.${PROJECT_NAME}.docker/?db=${DB_NAME}"
URLS="${URLS} ${URLS_PROJECT} ${URLS_LOCAL}"

for i in ${URLS}; do
    LABEL=${i%,*}:
    URL=${i#*,}
    printf "%-20s %s\n" "${LABEL}" "${URL}"
done

echo ""
