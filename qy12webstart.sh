#!/bin/sh
#write by luoysx
net=`netstat -anp|grep nginx|wc -l`
if [ $net -ge 2 ];then
    echo "nginx started"
else
    service nginx start
fi
