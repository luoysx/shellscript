#!/bin/sh
#write by luoysx
#touch /root/1.txt
web=(
http://blog.oldboyedu.com
http://blog.etiantian.org
http://oldboy.blog.51cto.com
http://www.luoysx.cn
http://www.baidu.cn
http://www.1.com
)
for((i=0;i<${#web[*]};i++))
do
#   cu=`curl -I ${web[$i]}>/root/1.txt`
#   cu2=`cat 1.txt|grep 200 |awk -F " " '{print $2}'`
#    cu=`curl -I ${web[$i]}>/root/1.txt|xargs cat /root/1.txt|grep200 |awk -F " " '{print $2}'`
   cu=`curl -I -m 10 -o /dev/null -s -w %{http_code} ${web[$i]}`
   if [ $cu -eq "200" -o $cu -eq 301 -o $cu -eq 302 ];then
       echo "${web[$i]} is OK."
   else
       echo "${web[$i]} is not OK."
   fi
done
