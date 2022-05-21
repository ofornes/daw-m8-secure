#!/bin/bash
set -e

psql -v ON_ERROR_STOP=0 --username "$POSTGRES_USER" <<-EOSQL
	CREATE USER $USER PASSWORD '$PASSWORD';
	CREATE DATABASE $DATABASE;
	GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $USER;
EOSQL