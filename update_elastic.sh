#!/bin/bash
#Checking for master node. E17
ORIGINAL_17_YML="/etc/elasticsearch/elasticsearch.yml"
UPDATED_17_YML="/opt/www/files/elasticsearch-17/elasticsearch.yml"
ORIGINAL_17_YML_SHA=$(sha256sum /etc/elasticsearch/elasticsearch.yml | awk '{print $1}')
UPDATED_17_YML_SHA=$(sha256sum /opt/www/files/elasticsearch-17/elasticsearch.yml | awk '{print $1}')
#Let me perform magic"
if [ "$ORIGINAL_17_YML_SHA" != "$UPDATED_17_YML_SHA" ]; then
        echo "Updating elasticsearch-17 Master node config"
        rm -rf $ORIGINAL_17_YML
        /bin/cp -rf $UPDATED_17_YML $ORIGINAL_17_YML
        chown root:elasticsearch $ORIGINAL_17_YML
        chmod 0755 $ORIGINAL_17_YML
fi