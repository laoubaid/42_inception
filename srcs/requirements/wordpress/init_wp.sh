#!/bin/sh

set -eu

echo "$WP_ADMIN$WP_ADMIN_PASSWD$WP_SITE$WP_ADMIN_EMAIL$WP_USER$WP_USER_PASSWD$WP_USER_EMAIL" > /dev/null
echo "$DOMAIN_NAME$DB_NAME$DB_USER$DB_PASS$DB_HOST" > /dev/null

TRIES=0
MAX_TRIES=10

if [ ! -f "/var/www/wordpress/wp-includes/version.php" ]; then
    wp core download --allow-root
fi

until mariadb -h $DB_HOST -u $DB_USER -p$DB_PASS --skip-ssl --connect-timeout=3 -e "SELECT 1;">/dev/null 2>/dev/null; do
    TRIES=$((TRIES + 1))
    if [ "$TRIES" -ge "$MAX_TRIES" ]; then
        echo "ERROR: MariaDB not available! Exiting..."
        exit 1
    fi
    sleep 1
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASS \
        --dbhost=$DB_HOST \
        --allow-root
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install \
        --url=https://$DOMAIN_NAME \
        --title=$WP_SITE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWD \
        --admin_email=$WP_ADMIN_EMAIL\
        --skip-email \
        --allow-root
    echo "WordPress installed successfully!"

    echo "Creating test user..."
    wp user create $WP_USER $WP_USER_EMAIL \
        --role=subscriber \
        --user_pass=$WP_USER_PASSWD \
        --display_name="Test User" \
        --allow-root
    echo "Test user created"
else
    echo "WordPress already installed, skipping..."
fi

exec php-fpm8.2 -F
