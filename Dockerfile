# Set the base image
FROM progrium/busybox

# File Author / Maintainer
MAINTAINER tanaka@infocorpus.com

# Install packages
RUN opkg-install bash wget tar

# Create directories
RUN mkdir -p /var/www && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/log/php-fpm && \
    mkdir -p /var/log/mariadb
RUN chmod -R 755 /var/lib/mysql
RUN chmod -R 755 /var/log

ADD start.sh /start.sh
RUN chown root:root /start.sh
RUN chmod +x /start.sh

# Setup Wordpress
RUN rm -rf /var/www/html
ADD https://ja.wordpress.org/latest-ja.tar.gz /wordpress.tar.gz
RUN tar zxvf /wordpress.tar.gz
RUN mv /wordpress /var/www/html
RUN rm -f /wordpress.tar.gz
RUN chown -R www-data:www-data /var/www/html

# Define mountable directories.
VOLUME ["/var/www/html", "/var/lib/mysql"]

CMD ["/bin/bash", "/start.sh"]
