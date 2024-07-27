#!/bin/bash

# Ensure the data directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server
service mariadb start;

# Check if the root password is set
function check_root_password {
    mysql -u $MARIADB_ROOT -p$MARIADB_ROOT_PASSWORD -e "EXIT" 2>/dev/null
    return $?
}


# Check if the root password is set and if not set it
if check_root_password; then
    echo "La contraseña para el usuario root está configurada."
else
    echo "No se necesita contraseña para el usuario root."
	mysql --verbose -u ${MARIADB_ROOT} -e "ALTER USER '${MARIADB_ROOT}'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
fi

# Create the database and user
DB_EXISTS=$(mysql -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "SHOW DATABASES LIKE '${MARIADB_NAME}';" | grep ${MARIADB_NAME})

if [ -n "$DB_EXISTS" ]; then
	echo "Mariadb ${MARIADB_NAME} database exists."
else
	echo "Mariadb ${MARIADB_NAME} database does not exist."
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE ${MARIADB_NAME}; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "ALTER USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MARIADB_ROOT} -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}' WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi
chmod -R 777 ${MARIADB_PATH} 
chown -R mysql:mysql ${MARIADB_PATH}
echo "start mysqld"
mysqld
echo "shutdown mysql"
mysqladmin -u ${MARIADB_ROOT} --password=${MARIADB_ROOT_PASSWORD} shutdown
