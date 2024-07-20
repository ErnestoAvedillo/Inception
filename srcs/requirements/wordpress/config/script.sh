#!/bin/bash

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

