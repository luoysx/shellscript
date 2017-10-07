#!/bin/bash
#write by luoysx
. /etc/init.d/functions
ran=(
21029299
00205d1c
a3da1677
1f6d12dd
890684b
)
for ((n=0;n<=32767;n++))
do
for((i=0;i<${#ran[*]};i++))
do
        md5=`echo $n | md5sum|cut -c 1-8`
        if [ $md5 == ${ran[$i]} ]
                then
                echo "$n" "${ran[$i]} "
                fi
done
done
