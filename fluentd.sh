#!/bin/sh

exec /usr/local/bin/fluentd -c /etc/fluent.conf -vv >>/var/log/fluentd.log 2>&1
