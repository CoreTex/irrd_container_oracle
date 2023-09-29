#!/bin/bash

# Start the postgres database
su postgres -c 'pg_ctl -D /var/lib/pgsql/data start'
echo "started postgres"

# create database if needed
su postgres -c "psql <<EOF
CREATE DATABASE irrd;
CREATE ROLE irrd WITH LOGIN ENCRYPTED PASSWORD 'irrd';
GRANT ALL PRIVILEGES ON DATABASE irrd TO irrd;
\c irrd
CREATE EXTENSION IF NOT EXISTS pgcrypto;
EOF"
echo "created database"

# Start redis cache
redis-server &

echo "started redit"

# upgrade irrd database
/home/irrd/irrd-venv/bin/irrd_database_upgrade

# Start irrd
/home/irrd/irrd-venv/bin/irrd --foreground --config /etc/irrd.yaml &

echo "irrd started"

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
