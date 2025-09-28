FROM debian:bullseye

# Install PHP-FPM, the MySQL extension for PHP, and curl
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql curl mariadb-client

# Create the directory needed by PHP-FPM
RUN mkdir /run/php

# Set the working directory for our web files
WORKDIR /var/www/html

# Download, extract, and clean up WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xvf latest.tar.gz && \
    mv wordpress/* . && \
    rm latest.tar.gz && rm -rf wordpress

# Download and install the WordPress Command Line Interface (wp-cli)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Copy and make our configuration script executable
COPY ./tools/configure.sh /usr/local/bin/configure.sh
RUN chmod +x /usr/local/bin/configure.sh

# Set the entrypoint to our configuration script
ENTRYPOINT [ "configure.sh" ]

# Set the default command to run PHP-FPM in the foreground
CMD [ "php-fpm7.4", "-F" ]