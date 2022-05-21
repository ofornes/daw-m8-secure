#!/bin/bash

# ENV HOST=localhost
# ENV PORT=5432
# ENV USER=odoo
# ENV PASSWORD=odoo
# ENV DATABASE=odoodb
# ENV PROXYMODE=yes

if [ "${PROXYMODE}" == "yes" ]; then
    FLG_PROXY=--proxy-mode
else
    FLG_PROXY=
fi

cd /var/lib/odoo
python3 -m venv odoo-venv
source odoo-venv/bin/activate
pip3 install wheel
pip3 install -r odoo/requirements.txt
deactivate

cd /var/lib/odoo
touch odoo.log
tail -f odoo.log &
exec odoo-venv/bin/python3 odoo/odoo-bin \
--logfile /var/lib/odoo/odoo.log \
--log-level warn \
--db_host ${HOST} \
--db_port ${PORT} \
--db_password "${PASSWORD}" \
--db_user ${USER} \
--database ${DATABASE} \
--addons-path /var/lib/odoo/addons \
--http-port 80 \
${FLG_PROXY}