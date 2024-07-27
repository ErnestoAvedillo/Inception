FROM debian:11-slim

ARG MARIADB_PATH
#
RUN apt-get -qq update -y 
RUN apt-get -qq install apt-file -y
RUN apt-file update
RUN apt-get -qq install mariadb-server vim -y
#
## Ensure the MariaDB directories exist with proper permissions
RUN echo "MARIADB_PATH: ${MARIADB_PATH}"
RUN mkdir -p ${MARIADB_PATH} 
RUN chmod -R 777 ${MARIADB_PATH} 
RUN chown -R mysql:mysql ${MARIADB_PATH}
#
# Copy the MariaDB configuration file
COPY ./config/config.cnf /etc/mysql/mariadb.conf.d/

# Copy the MariaDB initialization script
COPY ./config/mariadb_init.sh /run/mysqld/
RUN chown mysql:mysql /run/mysqld && chmod -R 755 /run/mysqld

#
EXPOSE 3306

CMD ["/var/run/mysqld/mariadb_init.sh"]

#ENTRYPOINT [ "bash", "-c", "while true; do sleep 3306; done"]
