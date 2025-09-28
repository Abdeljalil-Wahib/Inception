#!/bin/bash

# Start MariaDB in the background
mysqld_safe --nowatch &

# Wait for MariaDB to be ready
until mysqladmin ping &>/dev/null; do
    echo -n "."; sleep 1
done
echo "MariaDB started."

# Check if the database already exists to prevent re-initialization
if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Database already exists. Skipping setup."
else
    echo "Database not found. Starting setup..."
    # Set the root password and create the database and user
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
    echo "Database setup complete."
fi

# Shut down the background server
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Execute the command passed to the script (CMD from Dockerfile)
exec "$@"