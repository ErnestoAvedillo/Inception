#!/bin/bash
echo WP_PATH=$WP_PATH
echo MARIADB_DB_NAME=$MARIADB_DB_NAME
echo MARIADB_USER=$MARIADB_USER
echo MARIADB_USER_PASSWORD=$MARIADB_USER_PASSWORD
echo MARIADB_HOST=$MARIADB_HOST
echo DOMAIN_NAME=$DOMAIN_NAME
echo WP_TITLE=$WP_TITLE
echo WP_ADMIN_USER=$WP_ADMIN_USER
echo WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD
echo WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL
echo WP_USER=$WP_USER
echo WP_USER_EMAIL=$WP_USER_EMAIL
echo WP_USER_ROLE=$WP_USER_ROLE
echo WP_USER_PASSWORD=$WP_USER_PASSWORD
echo ****************************************************
if [ -d ${WP_PATH}"wp-admin" ]; then
	 echo "WordPress core is already downloaded"
else
	echo "WordPress Installing"
	wp core download  --path="${WP_PATH}" --allow-root
	wp config create  --path="${WP_PATH}" --dbname="${MARIADB_DB_NAME}" --dbuser="${MARIADB_USER}" --dbpass="${MARIADB_USER_PASSWORD}" --dbhost="${MARIADB_HOST}" --allow-root
	wp core install   --path="$WP_PATH" --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}"  --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root
	wp user create    --path="${WP_PATH}" "${WP_USER}" "${WP_USER_EMAIL}" --role="$WP_USER_ROLE" --user_pass="${WP_USER_PASSWORD}" --allow-root
	wp theme activate twentytwentytwo --path="${WP_PATH}" --allow-root
fi
/usr/sbin/php-fpm7.3 -F

