#!/bin/sh
#Filename: test.sh
if [ $# -lt 1 ];then
   echo "please input server name."
   exit 1
fi
chkconfig | grep $1 | {
    while read svr status;
    do
        if [ $svr = $1 ];then
            echo "server: $svr exist"
        fi
    done
}
