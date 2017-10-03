#!/bin/sh
#write by luoysx
n=`nmap -v` >> /dev/null 2>&1
if [ $? -ne 0 ];then
   yum -y install nmap 
  else
   read -p "请输入想扫描存活的IP段{例:192.168.1.1/24}" a
   nmap -sP $a
fi
