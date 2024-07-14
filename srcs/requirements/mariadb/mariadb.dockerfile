FROM debian:10-slim

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./config/config.cnf /etc/mysql/mariadb.conf.d/