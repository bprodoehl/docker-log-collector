#!/bin/bash

### Pull the necessary containers
docker pull balsamiq/docker-elasticsearch
docker pull bprodoehl/kibana
docker pull bprodoehl/log-collector

### Launch them
# Launch ElasticSearch
docker run -d \
           --name elasticsearch \
           --hostname elasticsearch \
           balsamiq/docker-elasticsearch

# Launch Kibana
docker run -d \
           -e KIBANA_SECURE=false \
           --link elasticsearch:es \
           --name kibana \
           --hostname kibana \
           bprodoehl/kibana

# Launch the log collector
docker run -d \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v /var/lib/docker/containers:/var/lib/docker/containers \
           --link elasticsearch:es1 \
           --name collector \
           --hostname collector \
           bprodoehl/log-collector

### Open up Kibana in your default browser
OPEN_CMD=open
for cmd in xdg-open gnome-open sensible-browser open;
do
    which $cmd &> /dev/null
    if [ 0 == $? ]; then
        OPEN_CMD=$cmd
        break
    fi
done  

echo Giving things a few seconds to spin up...
sleep 5

echo Opening Kibana in default browser
KIBANA_IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' kibana`
$OPEN_CMD "http://$KIBANA_IP/index.html#/dashboard/file/logstash.json"
