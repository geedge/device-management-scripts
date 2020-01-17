#!/bin/bash
while [ 1 ];
do
	./minio server --address :9000 ./DATA1  >> ./minio.log 2>&1
	echo program crashed, restart at `date +"%w %Y/%m/%d, %H:%M:%S"` >> RESTART.log
	sleep 30
done

