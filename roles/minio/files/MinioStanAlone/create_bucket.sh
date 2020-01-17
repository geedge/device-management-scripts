#!/bin/sh

bucket_name=openbucket

#用户名密码改为实际的值
./mc config host add myminio http://127.0.0.1:9000 minio 1234567890

./mc mb myminio/$bucket_name
./mc policy public myminio/$bucket_name

