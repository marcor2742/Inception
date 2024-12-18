#!/bin/bash

# Creare il file di configurazione cloud vuoto
# mkdir -p /var/lib/netdata/cloud.d
# touch /var/lib/netdata/cloud.d/cloud.conf

# Debug: stampare le variabili d'ambiente
echo "SQL_USER: ${SQL_USER}"
echo "SQL_PASSWORD: ${SQL_PASSWORD}"
echo "SQL_DATABASE: ${SQL_DATABASE}"

# Assicurarsi che il percorso esista
mkdir -p /etc/netdata/python.d

# Debug: verificare i permessi della directory
ls -ld /etc/netdata/python.d

touch /etc/netdata/python.d/mysql.conf

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

# Debug: verificare se il file è stato creato
if [ -f /etc/netdata/python.d/mysql.conf ]; then
  echo "Il file di configurazione MySQL è stato creato con successo."
else
  echo "Errore: il file di configurazione MySQL non è stato creato."
fi

# Debug: mostrare il contenuto del file
cat /etc/netdata/python.d/mysql.conf

netdata -D