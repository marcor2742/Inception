#!/bin/bash

set -e

service mariadb start

sleep 10

mariadb -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"

mariadb -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'localhost' IDENTIFIED BY '$SQL_PASSWORD';"

mariadb -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
#mariadb -e "CREATE USER IF NOT EXISTS 'netdata'@'localhost';"
#mariadb -e "GRANT USAGE, REPLICATION CLIENT, PROCESS ON *.* TO 'netdata'@'localhost';"

mariadb -e "FLUSH PRIVILEGES;"

kill `cat /var/run/mysqld/mysqld.pid`

mariadbd
