#!/bin/sh

#set hostname of container
XMAGE_DOCKER_SERVER_IP=${1:-localhost}

CONTAINER_ID=`docker ps -aqf "name=xmage"`
IS_RUNNING=`docker ps -q -f "name=xmage"`

if [ ! -z $CONTAINER_ID ] && [ -z $IS_RUNNING ]; then
    sudo docker rm $CONTAINER_ID
fi

if [ -z $IS_RUNNING ]; then
    sudo docker run --name xmage -d -p 17171:17171 -p 17179:17179 -e "XMAGE_DOCKER_SERVER_IP=$XMAGE_DOCKER_SERVER_IP" --hostname "$XMAGE_DOCKER_SERVER_IP" --net=container_isolated jniesz/xmage
fi
