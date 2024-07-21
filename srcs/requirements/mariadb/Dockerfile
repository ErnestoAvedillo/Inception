FROM debian:11-slim

ARG MARIADB_PATH
#
RUN apt-get update -y 
RUN apt-get install mariadb-server -y
#
## Ensure the MariaDB directories exist with proper permissions
RUN mkdir -p /var/run/mysqld 
########RUN mkdir -p /var/lib/mysql && chown mysql:mysql /var/lib/mysql && chmod -R 755 /var/lib/mysql
#
COPY ./config/config.cnf /etc/mysql/mariadb.conf.d/
#
COPY ./config/mariadb_init.sh /var/run/mysqld/
RUN chown mysql:mysql /var/run/mysqld && chmod -R 755 /var/run/mysqld
#########RUN chmod -R 777 /tmp/mariadb_init.sh 
#########RUN chown -R mysql:mysql /tmp/mariadb_init.sh

#
RUN chmod -R 777 ${MARIADB_PATH} 
RUN chown -R mysql:mysql ${MARIADB_PATH}
#
EXPOSE 3306

CMD ["/var/run/mysqld/mariadb_init.sh"]

#ENTRYPOINT [ "bash", "-c", "while true; do sleep 3306; done"]
