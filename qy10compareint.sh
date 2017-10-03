#!/bin/sh
#write by luoysx
echo "比较2个整数的大小"
read -p "请输入第一个整数" a
expr $a + 1 &> /dev/null
c=$?
read -p "请输入第二个整数" b
expr $b + 1 &> /dev/null
d=$?
test $c -eq 0 -a $d -eq 0 ||{
    echo "请输入整数"
    exit 1
}
[ $a -gt $b ]&&echo "$a > $b"
[ $a -lt $b ]&&echo "$a < $b"
[ $a -eq $b ]&&echo "$a = $b"
