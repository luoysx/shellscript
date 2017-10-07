#!/bin/bash
. /etc/init.d/functions
MD5PASS=(
21029299
00205d1c
a3da1677
1f6d12dd
890684b
)
for ((n=0;n<=32767;n++))
do
for((i=0;i<${#MD5PASS[*]};i++))
do
        md5=`echo $n | md5sum|cut -c 1-8`
        if [ $md5 == ${MD5PASS[$i]} ]
                then
                echo "$n" "${MD5PASS[$i]} "
                fi
done
done
