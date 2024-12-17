set -e

if [ ! -f /var/www/html/wp-config.php ]; then

	wp core download --allow-root \
					--path='/var/www/html'


	wp config create	--allow-root \
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/html'
						
	wp core install --allow-root \
					--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_USER \
					--admin_password=$WP_PASSWORD \
					--admin_email=$WP_EMAIL \
					--path='/var/www/html'

	wp user create $WP_USER2 $WP_EMAIL2 \
					--role=editor \
					--user_pass=$WP_PASSWORD2 \
					--allow-root \
					--path='/var/www/html'

	wp config set WP_REDIS_HOST redis --add --allow-root
    wp config set WP_REDIS_PORT 6379 --add --allow-root
    wp config set WP_CACHE true --add --allow-root

    wp plugin install redis-cache --allow-root
    wp plugin activate redis-cache --allow-root
    wp plugin update --all --allow-root

    wp redis enable --allow-root

    wp cache flush --allow-root

fi


mkdir -p /run/php

echo "Starting PHP-FPM"

/usr/sbin/php-fpm7.4 -F