#!/bin/bash

set -e

FIRST=1

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "MariaDB data directory already initialized"
    FIRST=0
fi

# Ensure the directory for the Unix socket exists
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB server"
mysqld_safe --user=mysql --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid &
pid="$!"

echo "pid: $pid"

for i in {30..0}; do
    if mysqladmin ping --silent; then
        break
    fi
    echo "Waiting for MariaDB to start..."
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 "MariaDB did not start"
    exit 1
fi

# if [ "$FIRST" -eq "0" ]; then
#     echo "Running mysql_upgrade"
#     mysql_upgrade -u root -p"${MYSQL_ROOT_PASSWORD}"
# fi

# Database Setup
if [ "$FIRST" -eq "1" ]; then
    DB_PASS=""
    echo "First time setup"
else
    DB_PASS="-p${SQL_ROOT_PASSWORD}"
    echo "Not first time setup"
fi

echo "Setting up database and users"
mysql -u root ${DB_PASS} <<EOSQL
    CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    ALTER USER 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;

    CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};

    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    ALTER USER '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL


echo "Stopping MariaDB server"

kill `cat /var/run/mysqld/mysqld.pid`
wait "$pid"

echo "Restarting MariaDB server"
mysqld --user=mysql --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid