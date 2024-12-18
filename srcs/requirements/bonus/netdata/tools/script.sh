#!/bin/bash

# Assicurarsi che il percorso esista
mkdir -p /etc/netdata/go.d

# Configurazione Docker
cat <<EOL > /etc/netdata/go.d/docker_engine.conf
jobs:
  - name: local
    url: unix:///var/run/docker.sock
EOL

# Configurazione Netdata
cat <<EOL > /etc/netdata/netdata.conf
[plugin:go.d]
  enabled = yes

[plugin:go.d:docker_engine]
  enabled = yes
EOL

# Avvia Netdata
netdata -D