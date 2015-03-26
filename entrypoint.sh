#!/bin/sh
set -e

WP_CONFIG=/var/www/html/wp-config.php

if [ ! -f $WP_CONFIG ]; then
    echo "=> Installing Wordpress ..."

    wget --no-check-certificate https://api.wordpress.org/secret-key/1.1/salt/

    # Configure Wordpress
    sed -i -e "/define('AUTH_KEY',         'put your unique phrase here');/,/require_once(ABSPATH . 'wp-settings.php');/d" /var/www/html/wp-config-sample.php
    cat index.html >> /var/www/html/wp-config-sample.php
    echo -e "define('FS_METHOD', 'direct');" >> /var/www/html/wp-config-sample.php
    cat wp-config-footer.php >> /var/www/html/wp-config-sample.php
    rm -f index.html
    rm -f wp-config-footer.php

    sed -e "s/database_name_here/$DB_NAME/
    s/username_here/$DB_USER/
    s/password_here/$DB_PASSWORD/
    s/localhost/$DB_HOST/" /var/www/html/wp-config-sample.php > $WP_CONFIG
    chown www-data:www-data $WP_CONFIG
    chmod 755 $WP_CONFIG

    echo "=> Done"
else
    echo "=> Using an existing Wordpress"
fi