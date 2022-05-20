# DAW - M8 - Pràctica de migració

Aquesta pràctica consisteix en la migració d’aplicacions de servidor, d’un a un altre.

Es tracta de demostrar com fer la còpia i restauració de dades i de com instal·lar i configurar el software al nou servidor.

Notes:

pg_dump -F t -b --insert --rows-per-insert=1 -h postgresdb -p 5432 -U moodle -W moodle -f moodle-db.tar
tar czf moodle-dirs.tgz -C /var/www/moodledata 
tar czf moodle-code.tgz -C /var/www/html
tar czf moodle-backup.tgz moodle-db.sql.gzip moodle-dirs.tgz moodle-code.tgz


Procés

1. Un cop creat les dues màquines
2. Crear usuari moodle a la màquina destí (només necessari per a restaurar, no cal que sigui permanent):
   `adduser --shell /bin/bash moodle`
   `echo moodle:moodle | chpasswd -`
3. Fer la còpia de seguretat a l'antiga màquina:
   - `pg_dump -b -F c -f moodle-db.dump -Z 9 --role=${DB_USER} -d ${DB_DATABASE} -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -W`
   - `tar czf moodle-code.tgz -C /var/www/html`
   - `tar czf moodle-dirs.tgz -C /var/www/moodledata`
4. Copiar els arxius creats a la nova màquina
   - `scp moodle-* moodle@nova_maquina:`
5. Procedir a restaurar, a la nova màquina
6. Des de host, fer:
   `docker compose exec nova_maquina bash`
7. Crear arxiu d'accés a bd al home del root:
   `echo ${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}:${DB_ENV_POSTGRES_DB}${DB_ENV_POSTGRES_USER}:${DB_ENV_POSTGRES_PASSWORD} > ~.pgpass`
8. Restaurar còpia:
   - `pg_restore -h ${DB_HOST} -p ${DB_PORT} -d ${DB_DATABASE} -U ${DB_USER} -w /home/moodle/moodle-db.dump`
   - `tar xzf /home/moodle/moodle-code.tgz --preserve-permissions --same-owner -C /var/www/html --strip-components=1`
   - `tar xzf /home/moodle/moodle-dirs.tgz --preserve-permissions --same-owner -C /var/www/moodledata --strip-components=1`
9. Reiniciar el servei apache per tal que tingui efecte
   - `sudo service apache2 restart`
10. Verificar amb el navegador
   - `https://nova_maquina`



Notes:

export DB_HOST=${DB_PORT_5432_TCP_ADDR}
export DB_PORT=${DB_PORT_5432_TCP_PORT}
export DB_DATABASE=${DB_ENV_POSTGRES_DB}
export DB_USER=${DB_ENV_POSTGRES_USER}
export DB_PWD=${DB_ENV_POSTGRES_PASSWORD}


useraddd -d /opt/odoo -m -s /bin/bash odoo
adduser --home /opt/odoo --shell /bin/bash odoo

pg_dump -b -F c -f dbdump -Z 9 --role=moodle -d ${DB_DATABASE} -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -W


${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}:${DB_ENV_POSTGRES_DB}${DB_ENV_POSTGRES_USER}:${DB_ENV_POSTGRES_PASSWORD}

tar czf $(date +%Y%m%d_%H%M%S%N-)moodle-dirs.tgz -C /var/www --exclude=moodledata/cache --exclude=moodledata/localcache \
--exclude=moodledata/sessions --exclude=moodledata/temp --exclude=moodledata/trashdir \
 --exclude=moodledata/backups moodledata
 
 
%Y%m%d_%H%M%S%N-
