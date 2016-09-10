# Pull base image.
FROM ubuntu:14.04

#set metadata
MAINTAINER jniesz

# DEBUG ONLY - Add root sudo access
#RUN echo "xmage ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/xmage && \
#    chmod 0440 /etc/sudoers.d/xmage

#Install base packages needed
RUN apt-get update && apt-get install -y software-properties-common

#Add Oracle repo
RUN apt-add-repository ppa:webupd8team/java -y && \
  echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
 
# Install Oracle Java
RUN apt-get update && apt-get install -y \
  jq \
  unzip \
  oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/*

#set working dira and create dir
WORKDIR /opt/xmage

#Get Xmage Server
RUN wget -qO- http://xmage.de/xmage/config.json | jq -r '.XMage.location' | wget -O xmage.zip -i- && \
  unzip xmage.zip && \
  rm xmage.zip && \
  chmod +x ./mage-server/startServer.sh && \
  sed -i -e 's/^java/exec java/g' ./mage-server/startServer.sh

#copy startup script
COPY dockerStartServer.sh ./mage-server/
RUN chmod +x ./mage-server/dockerStartServer.sh

# Create xmage user and change permissions
RUN useradd -c 'xmage server user' -m -d /home/xmage -s /bin/bash xmage && \
  chown -R xmage:xmage /opt/xmage
USER xmage

# XMage Defaults and env
ENV XMAGE_DOCKER_SERVER_IP="localhost" \
  XMAGE_DOCKER_SERVER_NAME="mage-server" \
  XMAGE_DOCKER_PORT="17171" \
  XMAGE_DOCKER_SECONDARY_BIND_PORT="17179" \
  JAVA_HOME=/usr/lib/jvm/java-8-oracle \
  HOME=/home/xmage

#Expose ports for xmage
EXPOSE 17171 17179

#set working directory for container
WORKDIR /opt/xmage/mage-server

# Define default command.
CMD ["./dockerStartServer.sh"]
