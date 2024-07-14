FROM debian:10-slim

ARG WP_PATH \
    WP_ADMIN_USER \
    WP_ADMIN_PASSWORD \
    WP_ADMIN_EMAIL \
    WP_USER \
    WP_USER_PASSWORD \
    WP_USER_EMAIL \
    WP_USER_ROLE

RUN apt-get update -y && apt-get install -y php-mysql php-fpm mariadb-server mariadb-client wget tar

RUN wget https://wordpress.org/latest.tar.gz

RUN mkdir -p $WP_PATH

RUN tar -xvf latest.tar.gz -C $WP_PATH

RUN chown -R www-data:www-data $WP_PATH

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf

COPY config/wp-config.php /

COPY config/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
