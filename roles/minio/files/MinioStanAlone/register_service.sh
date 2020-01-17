#!/bin/bash

local_ip=$(ifconfig eth2 | grep 'inet' |grep -v inet6 | awk '{print $2}')

data="{\"Name\":\"MinioCache\",\"ID\":\"$local_ip:9000\",\"Address\":\"$local_ip\",\"Port\":9000,\"EnableTagOverride\":true,\"Tags\":[\"group=TangoCache\",\"capacity=20\"],\"Check\":{\"id\":\"minio\",\"name\":\"Minio TCP on port 9000\",\"tcp\":\"$local_ip:9000\",\"interval\":\"10s\",\"timeout\":\"1s\"}}"

curl -s http://localhost:8500/v1/agent/service/register -X PUT -i -H "Content-Type:application/json" -d "$data"

#curl http://localhost:8500/v1/agent/service/deregister/$local_ip:9000

