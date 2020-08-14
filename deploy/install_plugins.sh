docker exec -it ckan bash -c " source /usr/lib/ckan/venv/bin/activate && cd /usr/lib/ckan/venv/src/ && 
                              pip install -e git+https://github.com/ckan/ckanext-harvest.git@v1.2.0#egg=ckanext-harvest && 
                              pip install -r /usr/lib/ckan/venv/src/ckanext-harvest/pip-requirements.txt && 
                              paster --plugin=ckanext-harvest harvester initdb --config=/etc/ckan/production.ini"

docker exec -it ckan bash -c " source /usr/lib/ckan/venv/bin/activate && 
                               cd /usr/lib/ckan/venv/src/ &&
                               rm -rf ckanext-spatial && 
                               pip install -e git+https://github.com/ckan/ckanext-spatial.git#egg=ckanext-spatial &&
                               rm -rf mims-ckan-catalogue &&
                               git clone https://github.com/SAEONData/mims-ckan-catalogue.git &&                               
                               cp -r mims-ckan-catalogue/ckanext-spatial/ckanext/spatial/* ckanext-spatial/ckanext/spatial/
                               pip install -r /usr/lib/ckan/venv/src/ckanext-spatial/pip-requirements.txt"

docker exec -it ckan bash -c " source /usr/lib/ckan/venv/bin/activate && 
                               cd /usr/lib/ckan/venv/src/ &&                               
                               rm -rf ckanext-mims-theme/ &&
                               cp -r mims-ckan-catalogue/ckanext-mims-catalogue/ ckanext-mims-theme/ &&
                               cd ckanext-mims-theme/ && python setup.py develop"
