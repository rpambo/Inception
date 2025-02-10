#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Wait for MySQL to start
sleep 10

# Install WordPress if not already installed
if [ ! -f /var/www/html/wp-config.php ]; then
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
    WP_USER_PWD=$(cat /run/secrets/wp_db_user_password)
    wp core download --allow-root

    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --allow-root --skip-check

    wp core install --url=$DOMAIN_NAME --title=$BRAND --admin_user=$WORDPRESS_ADMIN \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root

    # Create user only if it doesn't exist
    if ! wp user get $LOGIN --allow-root &> /dev/null; then
        wp user create $LOGIN $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root
    fi

    # Set FORCE_SSL_ADMIN to false
    wp config set FORCE_SSL_ADMIN 'false' --allow-root

    # Set permissions for wp-content
    chmod 777 /var/www/html/wp-content

    # Install and activate the theme
    wp theme install twentyfifteen --allow-root
    wp theme activate twentyfifteen --allow-root
    wp theme update twentyfifteen --allow-root
fi

# Start PHP-FPM
/usr/sbin/php-fpm7.3 -F
