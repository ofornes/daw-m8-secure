#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER $USER IDENTIFIED BY $PASSWORD;
	CREATE DATABASE $DATABASE;
	GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $USER;
EOSQL