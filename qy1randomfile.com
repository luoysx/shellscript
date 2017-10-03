#!/bin/bash
#write by luoysx
for random in  $(seq 1 10)
do
   random=`date +%s%N | md5sum | head -c 10`
   touch /etc/oldboy/$random\_oldboy.html
done
