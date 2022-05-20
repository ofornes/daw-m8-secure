#!/bin/bash

# Configuració apache
echo "ServerName ${APACHE_SERVER_NAME}" > /etc/apache2/conf-available/servername.conf
a2enconf servername.conf

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
