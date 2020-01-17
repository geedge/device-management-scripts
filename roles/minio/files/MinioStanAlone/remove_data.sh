#!/bin/bash
while [ 1 ];
do
	./mc rm -r --force --older-than=1 myminio/yspdata > /dev/null
done

