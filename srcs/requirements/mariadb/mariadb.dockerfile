FROM debian:10-slim

ARG MARIADB_PATH \
    MARIADB_NAME \
    MARIADB_USER \
    MARIADB_USER_PASSWORD \
    MARUADB_HOST

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./config/config.cnf /etc/mysql/mariadb.conf.d/
