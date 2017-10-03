#!/bin/sh
#write by luoysx
for i in `netstat -anp | grep -i ':80' | grep -i 'established'| awk '{print $5}' | cut -d: -f1 | sort |uniq -c |awk '{if ($1>15) {print $2}}'`
do
   iptables -A INPUT -p tcp -s $i -j DROP
done
