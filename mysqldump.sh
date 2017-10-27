#!/bin/bash
#write by luoysx
USER=root
PASSWD=JOHNluo@11
LOGIN="mysql -u$USER -p$PASSWD"
DATABASE=`$LOGIN -e "show databases;"|sed 1d|egrep -v "sche|mysql"`
DUMP="mysqldump -u$USER -p$PASSWD"
for database in $DATABASE
do
    [ ! -d /opt/$database ] && mkdir -p /opt/$database
 #   分库备份
 #   $DUMP $database > /opt/$database/${database}_$(date +%F).sql
    TABLE=`$LOGIN -e "show tables from $database;"|sed 1d`
    for table in $TABLE
    do
       $DUMP $database $table > /opt/$database/${database}_${table}_$(date +%F).sql
    done
done
