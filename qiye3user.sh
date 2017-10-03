#!/bin/bash
#write by luoysx
for i in `seq -w 1 10`
do
     passwd=`echo $RANDOM |md5sum |cut -c 1-10`
     useradd -s /sbin/nologin oldboy$i
     echo $passwd |tee -a /tmp/passwd.txt |passwd --stdin oldboy$i
    echo $passwd
done
