#!/bin/bash
#
cp -rf redis-server /usr/local/bin/
cp -rf redis-cli /usr/local/bin
cp -rf maat-redis.service /usr/lib/systemd/system/
cp -rf start-maat-redis /usr/local/bin
