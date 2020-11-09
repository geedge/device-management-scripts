#!/bin/bash

rm -rf /usr/lib/systemd/system/consul*service
rm -rf /usr/lib/systemd/system/consul*service
rm -rf /var/consul*
cp -f /opt/consul-client/etc/systemd/consul-client.service /usr/lib/systemd/system/consul-client.service
cp -f /opt/consul-client/bin/consul /usr/bin/
ln -sf /opt/consul-client/script/consul_path_setup.sh /etc/profile.d/



