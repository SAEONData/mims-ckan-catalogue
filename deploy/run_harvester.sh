

docker exec -itd ckan bash -c "source /usr/lib/ckan/venv/bin/activate && cd /usr/lib/ckan/venv/src/ &&  paster --plugin=ckanext-harvest harvester gather_consumer --config=/etc/ckan/production.ini &> /tmp/gather_consumer.log"


docker exec -itd ckan bash -c "source /usr/lib/ckan/venv/bin/activate && cd /usr/lib/ckan/venv/src/ && paster --plugin=ckanext-harvest harvester fetch_consumer --config=/etc/ckan/production.ini &> /tmp/fetch_consumer.log"

#2>&1 &

