FROM debian:11-slim

ARG MARIADB_PATH
#
RUN apt-get update -y 
RUN apt-get install mariadb-server -y
#
## Ensure the MariaDB directories exist with proper permissions
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld
RUN mkdir -p /var/lib/mysql && chown mysql:mysql /var/lib/mysql
#
COPY ./config/config.cnf /etc/mysql/mariadb.conf.d/
#
COPY ./config/mariadb_init.sh /tmp/
RUN chmod -R 777 /tmp/mariadb_init.sh 
RUN chown -R mysql:mysql /tmp/mariadb_init.sh

#
RUN chmod -R 777 ${MARIADB_PATH} 
RUN chown -R mysql:mysql ${MARIADB_PATH}
#
EXPOSE 3306

#CMD ["mysqld"]
CMD ["/tmp/mariadb_init.sh"]

#ENTRYPOINT [ "/bin/sh", "/tmp/mariadb_init.sh"]
