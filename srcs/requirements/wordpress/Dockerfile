FROM debian:11-slim

ARG WP_PATH 

RUN apt-get update -y && apt-get install -y php-mysql php-fpm mariadb-server mariadb-client wget tar curl

########RUN mkdir -p ${WP_PATH}wordpress/

WORKDIR /tmp/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#RUN wget https://wordpress.org/latest.tar.gz
#RUN tar -xvf latest.tar.gz

RUN mkdir -p ${WP_PATH}
#RUN mv ./wordpress/* ${WP_PATH}

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf
COPY config/wp-config.php ${WP_PATH}

WORKDIR ${WP_PATH}

RUN chmod -R 777 ${WP_PATH} && chown -R www-data:www-data ${WP_PATH}

EXPOSE 9000

COPY config/script.sh /

RUN chmod +x /script.sh

CMD ["bash","-c", "while true; do sleep 3600; done"]
#ENTRYPOINT ["bash", "/opt/wp_init.sh"]
