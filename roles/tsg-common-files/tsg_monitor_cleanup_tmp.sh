#!/bin/sh
cd /tmp/__tsg_monitor_tmp_dir

if [ $? != 0 ]; then
    #echo "cd to dir error!"
    exit 1
fi

#cur_dir=`pwd`
#echo "cur dir is: $cur_dir"

find . -ctime +1 -type d -name "_MEI*" | xargs rm -rf

