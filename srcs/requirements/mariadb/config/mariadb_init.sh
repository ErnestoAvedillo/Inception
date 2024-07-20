#!/bin/bash
# Ensure the data directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi
# sleep 3
service mariadb start;

# Start MariaDB server
#echo "Starting MariaDB..."
exec mysqld
mysql --verbose -u ${MARIADB_ROOT} -e "ALTER USER '${MARIADB_ROOT}'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

DB_EXISTS=$(mysql -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "SHOW DATABASES LIKE '${MARIADB_DB_NAME}';" | grep ${MARIADB_DB_NAME})

if [ -n "$DB_EXISTS" ]; then
	echo "Mariadb $MARIADB_DB_NAME database exists."
else
	echo "Mariadb $MARIADB_DB_NAME database does not exist."
	${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE $MARIADB_DB_NAME; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "ALTER USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL ON $MARIADB_DB_NAME.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi

mysqladmin -u ${MARIADB_ROOT} --password=${MARIADB_ROOT_PASSWORD} shutdown

#mysqld
