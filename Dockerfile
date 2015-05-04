# Set the base image
FROM dtanakax/storage

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, dtanakax@gmail.com

ENV WP_VERSION 4.2.1

# Install packages
RUN opkg-install curl tar

# Create directories
RUN mkdir -p /var/www/html && \
    mkdir -p /var/lib/mysql
RUN chmod -R 755 /var/www/html && \
    chmod -R 755 /var/lib/mysql

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Setup Wordpress
RUN rm -rf /var/www/html
RUN curl -k https://ja.wordpress.org/wordpress-$WP_VERSION-ja.tar.gz >> /wordpress.tar.gz && \
    tar zxvf /wordpress.tar.gz && \
    mv /wordpress /var/www/html && \
    rm -f /wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 777 /var/www/html

COPY wp-config-footer.php /wp-config-footer.php

# Environment variables
ENV DB_NAME         wordpress
ENV DB_USER         wpuser
ENV DB_PASSWORD     wppass
ENV DB_HOST         localhost

ENTRYPOINT ["./entrypoint.sh"]

VOLUME ["/var/www/html", "/var/lib/mysql"]

CMD ["configure"]

