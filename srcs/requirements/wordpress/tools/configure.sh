#!/bin/bash

# Wait for the MariaDB container to be ready before proceeding.
# It will try to connect every second until it succeeds.
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Check if wp-config.php already exists
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress configuration already exists."
else
    # Create the wp-config.php file using wp-cli
    wp config create --allow-root \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb:3306 --path='/var/www/html'
fi

# Execute the command passed to the script (CMD from Dockerfile)
exec "$@"