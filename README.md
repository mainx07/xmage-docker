# xmage-docker

This will build an xmage-server docker image based on Ubuntu 14.04.
Parts of the code is based on docker-xmage-apline, see: https://github.com/goesta/docker-xmage-alpine

## Build the docker image
    docker build -t jniesz/xmage .

## Run the docker start script
The bind interface is the interface name of the interface inside the container that you want the xmage server to bind to.
    ./start_xmage.sh [bind interface]
