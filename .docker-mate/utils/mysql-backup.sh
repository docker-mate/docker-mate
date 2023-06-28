#!/usr/bin/env bash

if ! docker ps -q --no-trunc | grep -q "$(docker compose ps -q db)"; then
    echo "No DB container is running."
    exit
fi

if [[ -f "./backup/mysql.sql.gz" ]]; then
    bash .docker-mate/utils/message.sh warning "Attention!"
    echo "Existing backup file found: backup/mysql.sql.gz"
    echo "Use r to rename the old dump"
    echo ""
    read -e -r -p "Do you want to override the backup file? [N/r/y]: " backupOK
    [[ -z "${backupOK}" ]] && backupOK="N"
else
    backupOK="Yes"
fi
if [[ "${backupOK,,}" == "r" ]]; then
    mv backup/mysql.sql.gz backup/mysql_"$(stat -c %W backup/mysql.sql.gz | awk '{print strftime("%Y%m%d_%H%M", $1)}')".sql.gz
    backupOK="Yes"
fi
if [[ "${backupOK,,}" == "yes" ]] || [[ "${backupOK,,}" == "y" ]]; then
    bash .docker-mate/utils/message.sh info "Creating a backup of your database in backup/mysql.sql.gz"
    mkdir -p backup
    docker compose exec db mariadb-dump -u "${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" | gzip >"backup/mysql.sql.gz"
    bash .docker-mate/utils/message.sh success "Backup successful!"
fi
