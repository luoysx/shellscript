#!/bin/sh
netstat -an|grep tcp|awk -F' ' '{print $6}'|sort -n|uniq -c 
