#!/bin/bash
killall minio_dmn.sh minio
./minio_dmn.sh &>/dev/null &
