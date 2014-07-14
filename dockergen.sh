#!/bin/sh

exec /app/docker-gen -watch -notify "sv restart fluentd" /app/templates/fluentd.conf.tmpl /etc/fluent.conf
