#!/bin/sh
set -e

DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-wpuser}
DB_PASSWORD=${DB_PASSWORD:-""}
DB_HOST=${DB_HOST:-""}

wget --no-check-certificate https://api.wordpress.org/secret-key/1.1/salt/

# Configure Wordpress
sed -i -e "/define('AUTH_KEY',         'put your unique phrase here');/,/define('NONCE_SALT',       'put your unique phrase here');/d" /var/www/html/wp-config-sample.php
echo -e "\n" >> /var/www/html/wp-config-sample.php
cat index.html >> /var/www/html/wp-config-sample.php
rm -f index.html

sed -e "s/database_name_here/$DB_NAME/
s/username_here/$DB_USER/
s/password_here/$DB_PASSWORD/
s/localhost/$DB_HOST/" /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php
chown www-data:www-data /var/www/html/wp-config.php
chmod 755 /var/www/html/wp-config.php

# For background
bash
