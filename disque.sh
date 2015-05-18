#!/bin/bash

chown disque:disque /data
chmod 0755 /data

exec /sbin/setuser disque /usr/local/bin/disque-server /etc/disque/disque.conf

