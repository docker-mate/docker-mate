#!/usr/bin/env bash

if ! docker ps -q --no-trunc | grep -q "$(docker compose ps -q db)"; then
    echo "No DB container is running."
    exit
fi

if [[ -f "./backup/mysql.sql.gz" ]]; then
    bash .docker-mate/utils/message.sh info "Restoring ./backup/mysql.sql.gz"
    zcat "backup/mysql.sql.gz" | docker exec -i "$(docker compose ps -q db)" mysql -u "${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}"
    bash .docker-mate/utils/message.sh success "Restore successful!"
else
    bash .docker-mate/utils/message.sh info "No backup found: backup/mysql.sql.gz"
fi
