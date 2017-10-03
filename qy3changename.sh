#!/bin/sh
#write by luoysx
cd /etc/oldboy
for i in `ls`
do
    name=`echo $i|cut -c 1-10`
     mv ${name}_oldboy.html ${name}_oldgirl.HTML
done
