#!/bin/bash

# Iniciar el servei de CRON
service cron start

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
