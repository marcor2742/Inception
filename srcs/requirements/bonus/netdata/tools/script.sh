#!/bin/bash

# Creare il file di configurazione cloud vuoto
mkdir -p /var/lib/netdata/cloud.d
touch /var/lib/netdata/cloud.d/cloud.conf

# Configurazione MySQL
cat <<EOL > /etc/netdata/python.d/mysql.conf
local:
  name     : 'local'
  user     : '${SQL_USER}'
  pass     : '${SQL_PASSWORD}'
  host     : 'mariadb'
  port     : 3306
  db       : '${SQL_DATABASE}'
EOL

# Configurazione Nginx
cat <<EOL > /etc/netdata/python.d/nginx.conf
local:
  name  : 'local'
  url   : 'https://nginx/stub_status'
  ssl_verify : 'no'
EOL

netdata -D