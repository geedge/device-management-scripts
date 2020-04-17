#!/bin/sh

#mxn

#防止因上一次的命令阻塞或长时间未返回,
#导致10秒内还不结束, 要强行杀掉,
#否则长时间运行后, 会有大量后台进程运行!
killall_uncompleted_cmd(){
    killall -9 -q tsg_cluster_register
    #killall -9 -q tsg_diagnose_background
    killall -9 -q tsg_update_tags
	
	rm -rf /tmp/_MEI*
}

start_background_cmd(){
    #后台并发运行, 保证所有命令的开始运行时间基本一样，
    #且不会因某个命令网络拥塞、执行时间长等问题，阻塞while(1)主循环
    /opt/tsg/tsg-monitor/tsg_cluster_register > /dev/null &
    
    #mxn板只检测cpu, mem, disk等, 前台cli命令启用diagnose,
    #后台服务依靠oam snmp模块, 无需运行tsg_diagnose_background
    #/opt/tsg/tsg-monitor/tsg_diagnose_background &
    /opt/tsg/tsg-monitor/tsg_update_tags > /dev/null &
}

#return value: current time in ms
get_current_time_in_ms(){
    time_sec=`date +"%s"`
    time_nsec=`date +"%N"`
    #echo $time_sec
    #echo $time_nsec

    time_epoch_ms=`echo | awk -v a=$time_sec -v b=$time_nsec '{printf("%.f"), a*1000+b/1000/1000}'`

    echo $time_epoch_ms
}

#args:
#begin from time, in ms
#wait for n ms
sleep_for_time_ms(){
    last_time=$1
    wait_sec=$2
    #break_time=`echo | awk -v a=$last_time -v b=$wait_sec '{printf("%.f"), a+b}'`
    break_time=`expr $last_time + $wait_sec`
    break_time_int=`expr $break_time`
    #echo "start: last_time is:$last_time, expect break timeis:$break_time!"

    current_time=0
    break_time=0
    #break_time=`expr $last_time + 1000*$1`
    while [ 1 ]; do
        current_time=`get_current_time_in_ms`
        current_time_int=`expr $current_time`
        if [ $current_time_int -ge $break_time_int ]; then
           #echo "current is: $current_time_int, break_time is:$break_time_int, break!"
           break
        else
           #echo "break is: $current_time_int, last_time is:$break_time_int, continue!"
           # usleep is us
           usleep 1000
        fi
    done

}

while [ 1 ]; do
    start_time=`get_current_time_in_ms`
    #echo tsg-monitor start at `date +"%Y/%m/%d, %H:%M:%S.%N"` >> /tmp/tsg-monitor.log
   
    start_background_cmd 
    sleep 13
    killall_uncompleted_cmd
    
    sleep_for_time_ms $start_time 15000
done
