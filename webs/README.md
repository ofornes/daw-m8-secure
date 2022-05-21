# Notes sobre com construir aquesta pràctica

## Environment

S’utilitzen variables ENV per a configurar els docker-files. D’aquesta manera evitem utilitzar passwords directament.

Les variables estan emmagatzemades a:

[environment.gpg](./environment.gpg)

Però s’ha d’utilitzar la clau GPG adient, que només tenen els interessats.



Podeu crear el vostre propi arxiu `.env` amb les vostres pròpies passwords. El contingut ha de ser així:

```properties
NEXTCLOUD_MYSQL_PASSWORD=****
WORDPRESS_DB_PASSWORD=****
MOODLE_DB_PASSWORD=****
MYSQL_ROOT_PASSWORD=****
POSTGRES_PASSWORD=****
```

Només heu d’assignar cada password en comptes dels `****`.

## Previ a docker-compose

Abans de fer el docker-compose, heu de crear una imatge amb python3. Això s’ha fet així per tal d’evitar les continues construccions que, tot i ser sempre el mateix, es refeia cada vegada que es tornava a fer build amb `--no-cache`.

Aquesta imatge s’anomena:

- dawm8-python3:latest
- dawm8-python3:0.0.1

El dockerfile de odoo parteix d’aquesta imatge. S'ha creat un arxiu script per a generar:
   ```bash
   build-imatge.sh
   ```



## Docker compose

Un cop teniu la imatge python, només heu de construir les imatges de compose. Podeu fer totes plegades o per separat. S’ha separat odoo per ser la que més problemes m’ha donat, però sou lliures d’integrar-les al docker-compose principal.

El procediment és:

1. Build

   ```bash
   docker compose -f docker-compose.yaml,docker-compose-odoo.yaml build --no-cache
   ```

   

2. Up

   ```bash
   docker compose -f docker-compose.yaml,docker-compose-odoo.yaml up -d
   ```

   



Si voleu verificar els logs, feu:

```bash
docker compose -f docker-compose.yaml,docker-compose-odoo.yaml logs
```



