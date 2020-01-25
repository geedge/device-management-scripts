#!/bin/bash
# ====================================================
# Main Script Test for Check ZHK's CSA-7400 Chassis ID
# Edit:Edgar.Tang
# Release date: 2019.9.16
# ====================================================
a=`date`
Tstart=$(date +%s)
Stime=`date +%Y%m%d-%H%M%S`
open_intf.inst 
patch=`pwd`
Version="A2"
#SPVer=`cat release_note.txt | grep VERSION | head -n 1 | awk -F ":" '{print $2}'`
i=0
chmod 777 *
rm -f *.log
rm -f *.LOG
rm -rf *.bin
rm -rf tmp*
rm -rf *dat
rm -rf *PASS
rm -rf *id
rm -rf *ipmi
clear
function maintest(){
#echo   "##########################################################################"
#echo   "=========================Check chassis id information===============" 
#echo   "-------------------------Check chassis id information---------------"

if [ ! -f "cmm_api_tst" ];then
    echo "not found cmm_api_tst!"
    exit 1
fi

./cmm_api_tst 9 1 1 127.0.0.1  | tee chid.id
if [ $? != 0 ]; then
    echo "cmm_api_tst failed!"
    exit 1
fi

CHID=`cat chid.id | sed -n '1p' | awk -F ":" '{print $2}' | sed 's/ //g'`
CHIDL=`echo $CHID | awk '{print length($0)}'`

if [ $CHIDL != 20 ];then
    echo "CHID length is not 20!"
    exit 1
fi

echo "{\"sn\": \"$CHID\"}" > ./tsg_sn.json
}

#echo   "#######################################################################"
#echo   "==========================Check Main Switch information================ "
#echo   "--------------------------Check Main Switch information----------------"

ipmitool  raw 0x2e 0x32 0x00 0x5f 0x13 | tee main.ipmi
ipmitool  raw 0x2e 0x32 0x00 0x5f 0x13 | tail -n 1 | awk '{print $5}' | sed 's/ //g' | grep 01
if [ $? == 0 ]; then
        echo "ipmitool: Check DUT Switch for Main!.......................................PASS"
        maintest $CHID $PSN $1
else
	sdrnum=`ipmitool sdr | grep -a ok | wc -l`
	if [ $sdrnum == 23 ]; then
                echo "sdrnum: Check DUT Switch for Main!.......................................PASS"
  	        maintest $CHID $PSN $1
        else
		echo   "===================================================================================="
		echo   "====================FFFFFF======A========IIIIIIIII===LL============================="
		echo   "====================F==========A=A===========I=======LL============================="
		echo   "====================F=========A===A==========I=======LL============================="
		echo   "====================FFFFF====AAAAAAA=========I=======LL============================="
		echo   "====================F=======A=======A========I=======LL============================="
		echo   "====================F======A=========A=======I=======LL============================="
		echo   "====================F=====A===========A==IIIIIIIII===LLLLLLLLL======================"
		echo   "===================================================================================="
		echo "FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL" 
		echo "Check DUT Switch for Main!......................................FAIL"
		echo "====================================================================================== "
		echo "Please changed CMM for Main and please reboot another CMM via Serial Port;then retest"
		echo "====================================================================================== "
		read
		i=1
		exit 1
	fi
fi


#end=$(date +%s)
#endt=$((end-Tstart))
#echo "Test time: $endt seconds" 
#
#clear
#echo "========================================================================"
#echo "Chassis Program Ver            : $SPVer"
#echo "------------------------------------------------------------------------"
#echo "Chassis ID                     : $CHID"
#echo "Chassis ID length              : $CHIDL"
#echo "------------------------------------------------------------------------"
#echo "Test Time         : $endt seconds"
#echo   "========================================================================"
#echo   "=================PPPPP=======A=======SSSSSSSSS==SSSSSSSS================"
#echo   "=================P====P=====A=A======S==========S======================="
#echo   "=================P====P====A===A=====S==========S======================="
#echo   "=================PPPPP====A=====A====SSSSSSSSS==SSSSSSSS================"
#echo   "=================P=======AAAAAAAAA===========S=========S================"
#echo   "=================P======A=========A==========S=========S================"
#echo   "=================P=====A===========A=SSSSSSSSS==SSSSSSSS================"
#echo   "========================================================================"

#echo "Chassis ID                     : $CHID"
