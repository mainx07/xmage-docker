#!/bin/sh

#set default value to em1
XMAGE_DOCKER_SERVER_INTERFACE=${1:-em1}

CONTAINER_ID=`docker ps -afq "name=xmage"`
IS_RUNNING=`docker ps -q -f name=xmage`
if [ ! -z $CONTAINER_ID ] && [ -z $IS_RUNNING ]; then
    sudo docker rm $CONTAINER_ID
fi

if [ -z $IS_RUNNING ]; then
    sudo docker run --name xmage -d -p 17171:17171 -p 17179:17179 -e "$XMAGE_DOCKER_SERVER_INTERFACE" --net=host jniesz/xmage
fi
