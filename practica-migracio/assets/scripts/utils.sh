#!/bin/bash

# Utilities functions
function dbsetenv() {
    export DB_HOST=${DB_PORT_5432_TCP_ADDR}
    export DB_PORT=${DB_PORT_5432_TCP_PORT}
    export DB_DATABASE=${DB_ENV_POSTGRES_DB}
    export DB_USER=${DB_ENV_POSTGRES_USER}
    export DB_PWD=${DB_ENV_POSTGRES_PASSWORD}
}
function createpgpass() {
    if [[ ! -f ~/.pgpass ]]; then
        echo "${DB_HOST}:${DB_PORT}:${DB_DATABASE}:${DB_USER}:${DB_PWD}" > ~/.pgpass
        chmod 0600 ~/.pgpass
    fi
}

# Wait for database server
function wait-postgres() {
    createpgpass

    DOK=-1
    VEGADES=5

    while [ $DOK -ne 0 ] && [ $VEGADES -gt 0 ]
    do
        PGPASSFILE=~/.pgpass pg_isready -h ${DB_HOST} -p ${DB_PORT} -d ${DB_DATABASE} -U ${DB_USER}
        DOK=$?
        ((VEGADES--))
        if [ $DOK -ne 0 ];
        then
                sleep 2
        fi

    done

    if [ $DOK -ne 0 ]; then
        echo "ERROR, el servidor POSTGRES NO ESTÀ DISPONIBLE!! " | tee -a /var/log/error.log 1>&2
    fi
    return $DOK
}

# Restore database
function restore-db() {
    RETVAL=0

    if [ -f "$1" ]; then
        DIR=$(dirname $(realpath $1))
        FBK=$(basename $(realpath $1))
        EXT=${FBK##*.}
        cd $DIR
        createpgpass

        if [ "${EXT}" == "sql" ]; then
            psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_DATABASE} -U ${DB_USER} -w < ${FBK}
            RETVAL=$?
            if [ $RETVAL -eq 0 ]; then
                mv ${FBK} ${FBK}.restaurat
            fi
        fi

        if [ $RETVAL -eq 0 ] && [ "${EXT}" != "sql" ]; then
            pg_restore -h ${DB_HOST} -p ${DB_PORT} -d ${DB_DATABASE} -U ${DB_USER} -w ${FBK}
            RETVAL=$?
        fi

        cd -
    else
        echo "L'arxiu '$1' no existeix pas, no hi ha restauració possible!"
        RETVAL=-1
    fi
    return $RETVAL
}

function backup-db() {
    createpgpass

    if [ $? -eq 1 ]; then
        TIPUS=$1
    else
        TIPUS=c
    fi
    
    pg_dump -b -F ${TIPUS} -f moodle-db.dump -Z 9 --role=${DB_USER} -d ${DB_DATABASE} -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -w
    return $?
}

function backup-files() {
    RETVAL=0

    tar czf moodle-code.tgz -C /var/www html
    tar czf moodle-dirs.tgz -C /var/www --exclude=moodledata/cache --exclude=moodledata/localcache \
        --exclude=moodledata/sessions --exclude=moodledata/temp --exclude=moodledata/trashdir \
        --exclude=moodledata/backups moodledata
}

function restore-files() {
    tar xzf moodle-code.tgz --preserve-permissions --same-owner -C /var/www/html --strip-components=1
    tar xzf moodle-dirs.tgz  --preserve-permissions --same-owner -C /var/www/moodledata --strip-components=1
}