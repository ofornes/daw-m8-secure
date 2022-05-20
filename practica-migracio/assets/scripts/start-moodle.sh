#!/bin/bash
# This file is used by moodle container to start apache

# funcions
source /usr/local/bin/utils.sh
# Preparar variables
dbsetenv

if [ -f /etc/ssh/sshd_config.d/sshd_secure.conf ]; then
    # Reiniciar el servei per a agafar la configuració de securització
    service ssh restart
fi


# Iniciar el servei de CRON
service cron start

# Configuració apache
echo "ServerName ${SERVER_NAME}" > /etc/apache2/conf-available/servername.conf
a2enconf servername.conf

# Wait for database server
wait-postgres

if [ $? -ne 0 ]; then
    logger "Error, POSTGRESQL no disponible"
    exit -1
fi

# Restore database
restore-db /var/www/moodledata/backups/moodle-db.dump

read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
