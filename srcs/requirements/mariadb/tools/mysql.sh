#!/bin/bash

# if [ ! -d "/run/mysqld" ]; then
#     mkdir -p /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysql_install_db --user=root --datadir=/var/lib/mysql
# fi

# mkdir -p /var/run/mysqld
# chown -R mysql:mysql /var/run/mysqld
# chown -R mysql:mysql /var/lib/mysql

# mysqld_safe --pid-file=/run/mysqld/mysqld.pid &
# pid="$!"

# # mysql=( mysql --protocol=socket -uroot )

# for i in {30..0}; do
#     if mysqladmin ping --silent; then
#         break
#     fi
#     echo 'MySQL init process in progress...'
#     sleep 1
# done

# if [ "$i" = 0 ]; then
#     echo >&2 'MySQL init process failed.'
#     exit 1
# fi

set -e

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"

mariadb -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'localhost' IDENTIFIED BY '$SQL_PASSWORD';"

mariadb -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
mariadb -e "FLUSH PRIVILEGES;"

kill `cat /var/run/mysqld/mysqld.pid`

mariadbd
# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
# echo 6

# Riavviare MySQL
# exec mysqld_safe