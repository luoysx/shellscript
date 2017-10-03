#write by luoysx
> /tmp/temp.txt
input(){
while true
do
echo "抓阄程序，输入名字，产生号码(1-10)"
read -p "请输入名字:" n
 if [ -z $n ];then
        continue
 elif [ $n == "0" ];then
      break

 fi
 rand=$((RANDOM%10))
 echo -e $n"\t"$rand >>/tmp/temp.txt
done
}
output(){
cat /tmp/temp.txt |sort -n -k2 -r|sed '3a#################'
}
input
output
