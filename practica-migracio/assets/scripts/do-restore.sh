#!/bin/bash

# funcions
source /usr/local/bin/utils.sh
# Preparar variables
dbsetenv

if [ $# -ne 1 ]; then
    echo "Ha d'indicar el directori on trobar els arxius de còpia a restaurar!"
    echo "Ús:"
    echo "do-restore.sh directori"
    echo "En aquest directori s'han de trobar:"
    echo "      - moodle-code.tgz"
    echo "      - moodle-dirs.tgz"
    echo "      - moodle-db.dump"
	exit 1
fi

if [ ! -d $1 ]; then
    echo "El directori indicat '$1' no existeix o no és pas un directori!"
    exit -1
fi

BK_DIR=$(realpath $1)
DB_FILE="${BK_DIR}/moodle-db.dump"
FS_FILE="${BK_DIR}/moodle-dirs.tgz"
CD_FILE="${BK_DIR}/moodle-code.tgz"

if [ ! -f "${DB_FILE}" ]; then
    echo "L'arxiu de base de dades no existeix pas!"
    exit -1
fi
if [ ! -f "${FS_FILE}" ]; then
    echo "L'arxiu de FS no existeix pas!"
    exit -2
fi
if [ ! -f "${CD_FILE}" ]; then
    echo "L'arxiu de codi no existeix pas!"
    exit -3
fi

## Verificar connectivitat
wait-postgres
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error, no hi ha connectivitat amb el servidor '${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'"
    echo "No es pot restaurar l'arxiu!"
    exit -1
fi

cd ${BK_DIR}
echo "Intent de restaurar l'arxiu de base de dades '${DB_FILE}'..."
restore-db "${DB_FILE}"
RET=$?
if [ $RET -ne 0 ]; then
    echo "S'ha produït un error en restaurar la base de dades!"
    cd -
    exit -1
fi
echo "Base de dades restaurada!"

echo "Restaurant sistema d'arixus..."
restore-files
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error en restaurar els arxius!"
    cd -
    exit -4
fi

if [ -f /var/www/html/index.html ]; then
    echo "Eliminació d'arxiu anterior apache!"
    rm /var/www/html/index.html
fi
cd -
exit 0