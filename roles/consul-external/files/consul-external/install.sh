#!/bin/bash

rm -rf /usr/lib/systemd/system/consul*service
rm -rf /usr/lib/systemd/system/consul*service
rm -rf /var/consul*
cp -f /opt/consul-external/etc/systemd/consul-server.service /usr/lib/systemd/system/consul-server-external.service

ln -sf /opt/consul-external/script/consul_path_setup.sh /etc/profile.d/
systemctl daemon-reload



