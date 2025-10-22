#!/bin/bash
set -eu

echo "$DB_NAME$DB_USER$DB_PASS$DB_ROOT_PASS" > /dev/null

if [ -d "/var/lib/mysql/$DB_NAME" ]; then
    echo "Database already exists, skipping initialization..."
    exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
fi

echo "Starting temporary MariaDB for WordPress setup..."
mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
PID=$!

# Wait until MariaDB is ready
echo "Waiting for MariaDB to start..."
TRIES=0
MAX_TRIES=3
until mariadb -u root -e "SELECT 1;" >/dev/null 2>/dev/null; do
    TRIES=$((TRIES + 1))
    if [ "$TRIES" -ge "$MAX_TRIES" ]; then
        echo "ERROR: MariaDB failed to start!"
        exit 1
    fi
    sleep 1
done

echo ">> Creating WordPress database and user..."
mariadb -u root <<EOPrompt
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOPrompt

echo ">> Setup complete!"
kill "$PID"
wait "$PID" 2>/dev/null || true

exec mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0

