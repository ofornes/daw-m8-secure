#!/bin/bash

# ConfiguraciĆ³ apache
echo "ServerName ${APACHE_SERVER_NAME}" > /etc/apache2/conf-available/servername.conf
a2enconf servername.conf

# Iniciar el servei de CRON
service cron start

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
