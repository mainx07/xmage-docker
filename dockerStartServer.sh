#!/bin/sh

XMAGE_CONFIG=/opt/xmage/mage-server/config/config.xml
#SERVER_ADDRESS=$(ip addr show $XMAGE_DOCKER_SERVER_INTERFACE | grep 'state UP' -A2 | tail -n1 | awk -F'[/ ]+' '{print $3}')

sed -i -e "s#\(serverAddress=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SERVER_IP\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(serverName=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SERVER_NAME\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(port=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_PORT\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(secondaryBindPort=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SECONDARY_BIND_PORT\"#g" ${XMAGE_CONFIG}

exec ./startServer.sh
