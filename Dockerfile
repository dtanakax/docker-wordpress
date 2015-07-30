# Set the base image
FROM dtanakax/storage

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, dtanakax@gmail.com

ENV WP_VERSION 4.2.3

# Create directories
RUN mkdir -p /var/www && \
    mkdir -p /var/lib/mysql
RUN chmod -R 755 /var/lib/mysql

# Setup Wordpress
ADD https://ja.wordpress.org/wordpress-$WP_VERSION-ja.zip /wordpress.zip
RUN unzip /wordpress.zip && \
    mv /wordpress /var/www/html && \
    rm -f /wordpress.zip

RUN find /var/www/html -type d -exec chmod 705 {} \; && \
    find /var/www/html -type f -exec chmod 604 {} \;

COPY wp-config-footer.php /wp-config-footer.php
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Environment variables
ENV DB_NAME         wordpress
ENV DB_USER         wpuser
ENV DB_PASSWORD     wppass
ENV DB_HOST         localhost

ENTRYPOINT ["./entrypoint.sh"]

VOLUME ["/var/www/html", "/var/lib/mysql"]

CMD ["configure"]

