docker-log-collector
==============

A Docker container that collects the Docker logs of all running containers
using fluentd.  By default, it passes everything along to an ElasticSearch
container linked in as es1.


```
docker run -td \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v /var/lib/docker/containers:/var/lib/docker/containers \
           --link elasticsearch:es1 \
           --name collector bprodoehl/log-collector
```

This is based on the very excellent article at
http://jasonwilder.com/blog/2014/03/17/docker-log-management-using-fluentd/,
with a pile of real-world fixes added on top so that it all actually works, and time formats are properly parsed, and the logs can be read with Kibana, and so on.
