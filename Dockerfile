# Set the base image
FROM tanaka0323/storage

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

# Environment variables
ENV DB_NAME         wordpress
ENV DB_USER         wpuser
ENV DB_PASSWORD
ENV DB_HOST

# Install packages
RUN opkg-install wget tar

# Create directories
RUN mkdir -p /var/www/html && \
    mkdir -p /var/lib/mysql
RUN chmod -R 755 /var/www/html
RUN chmod -R 755 /var/lib/mysql

ADD entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Setup Wordpress
RUN rm -rf /var/www/html
ADD https://ja.wordpress.org/latest-ja.tar.gz /wordpress.tar.gz
RUN tar zxvf /wordpress.tar.gz
RUN mv /wordpress /var/www/html
RUN rm -f /wordpress.tar.gz
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 707 /var/www/html/wp-content
ADD wp-config-footer.php /wp-config-footer.php

# Define mountable directories.
VOLUME ["/var/www/html", "/var/lib/mysql"]

ENTRYPOINT ["/entrypoint.sh"]