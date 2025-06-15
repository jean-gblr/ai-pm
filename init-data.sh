#!/bin/bash
set -e

if [ -n "${POSTGRES_NON_ROOT_USER:-}" ] && [ -n "${POSTGRES_NON_ROOT_PASSWORD:-}" ]; then
    SQL_COMMANDS=$(cat <<SQL
        CREATE USER "${POSTGRES_NON_ROOT_USER}" WITH PASSWORD '${POSTGRES_NON_ROOT_PASSWORD}';
        GRANT ALL PRIVILEGES ON DATABASE "${POSTGRES_DB}" TO "${POSTGRES_NON_ROOT_USER}";
        GRANT CREATE ON SCHEMA public TO "${POSTGRES_NON_ROOT_USER}";
SQL
    )
    echo "$SQL_COMMANDS" | psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB"
else
    echo "SETUP INFO: No Environment variables given!"
fi