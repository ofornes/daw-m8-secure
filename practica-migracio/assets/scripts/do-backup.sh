#!/bin/bash

# funcions
source /usr/local/bin/utils.sh
# Preparar variables
dbsetenv


## Crear el backup de la base de dades
if [ $# -lt 1 ]; then
    echo "Ha d'indicar el directori on deixar la còpia!"
	exit 1
fi

if [ ! -d $1 ]; then
    echo "El directori indicat '$1' no existeix o no és pas un directori!"
    exit -1
fi

BK_DIR=$(realpath $1)

## Verificar si podem escriure-hi
touch ${BK_DIR}/.can_delete 2> /dev/null
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error, no es pot escriure al directori '${BD_DIR}'"
    echo "No es pot fer la còpia de seguretat"
    exit -1
fi


cd ${BK_DIR}
echo "Fent còpia al directori ${BK_DIR}"


## Verificar connectivitat
wait-postgres
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error, no hi ha connectivitat amb el servidor '${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'"
    echo "No es pot fer còpia de la base de dades"
    cd -
    exit -1
fi

## BD
echo "Fent còpia de la base de dades..."
backup-db
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error, s'ha produït un problema en copiar la base de dades!"
    cd -
    exit -1
fi

## Arxius
echo "Fent còpia dels arxius..."
backup-files
RET=$?
if [ $RET -ne 0 ]; then
    echo "Error, s'ha produït un problema en copiar arxius o codi!"
    cd -
    exit -1
fi

## Desem tot en un sol arxiu
echo "Agrupant-ho tot en un sol arxiu..."
BK_FILE=$(date +%Y%m%d_%H%M%S%N)-moodle-bk.tgz
tar czf ${BK_FILE} moodle-dirs.tgz moodle-code.tgz moodle-db.dump
echo "Netejant arxius intermedis..."
rm moodle-dirs.tgz moodle-code.tgz moodle-db.dump

echo "Còpia realitzada correctament!"
echo "L'arxiu '${BK_FILE}' conté la còpia"
cd -
exit 0