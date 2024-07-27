FROM debian:11-slim

ARG WP_PATH 

RUN apt-get -qq update -y
RUN apt-get -qq install apt-file -y
RUN apt-file update

RUN apt-get -qq install -y php-mysql php7.4-fpm mariadb-client tar curl vim

########RUN mkdir -p ${WP_PATH}wordpress/

WORKDIR /tmp/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#RUN wget https://wordpress.org/latest.tar.gz
#RUN tar -xf latest.tar.gz

RUN mkdir -p ${WP_PATH}
RUN mkdir -p /run/php && chmod -R 777 /run/php && chown -R www-data:www-data /run/php
#RUN mv ./wordpress/* ${WP_PATH}

COPY config/wordpress.conf /etc/nginx/sites-available/wordpress.conf
COPY config/wordpress.conf /etc/php/7.4/fpm/pool.d/www.conf
#COPY config/wp-config.php ${WP_PATH}

WORKDIR ${WP_PATH}

RUN chmod -R 777 ${WP_PATH} && chown -R www-data:www-data ${WP_PATH}

EXPOSE 9000

COPY config/script.sh /tmp/

RUN chmod +x /tmp/script.sh

#CMD ["bash","-c", "while true; do sleep 3600; done"]
ENTRYPOINT ["bash", "/tmp/script.sh"]
