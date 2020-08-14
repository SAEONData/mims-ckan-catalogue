CKAN_INSTALL_DIR="/home/bmcalister/workspace/mims-catalogue/ckan/ckan/"

echo "Copying configs in place"

#if [ -f "$CKAN_INSTALL_DIR/contrib/docker/solr/solrconfig.xml" ]; then
#   cp ./ckan-configs/solrconfig.xml $CKAN_INSTALL_DIR/contrib/docker/solr/
#else
#   echo  "$CKAN_INSTALL_DIR does not exist"
#fi

if [ -f "$CKAN_INSTALL_DIR/ckan/config/solr/schema.xml" ]; then
    cp ./ckan-configs/schema.xml $CKAN_INSTALL_DIR/ckan/config/solr/
else
   echo  "$CKAN_INSTALL_DIR does not exist"
fi

echo "Re-building SOLR docker image with new configurations"

CURR_DIR=$(pwd)
echo $CURR_DIR

cd $CKAN_INSTALL_DIR/contrib/docker && docker stop solr && docker-compose build solr && docker-compose up -d solr

cd $CURR_DIR

sleep 5

echo "Re-indexing SOLR for spatial extensions"

docker exec -it ckan bash -c "source /usr/lib/ckan/venv/bin/activate && cd /usr/lib/ckan/venv/src/ && 
	                      paster --plugin=ckan search-index rebuild --config=/etc/ckan/production.ini"


