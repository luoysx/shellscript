#!/bin/sh
#write by luoysx
str="the squid project provides a number ofresources to assist users design,implement and support squid installations.Please browse the documentation and support sections for more infomation,byoldboy training."
#sed -i 's/\.\|\,/ /g' /root/1.txt
words(){
   echo $str|sed 's#[^a-zA-Z]# #g'|tr " " "\n"|grep -v "^$"|sort|uniq -c |sort -r -n
}
letters(){
   echo $str|grep -o "."|sort|egrep -v " |^$|[^a-zA-Z]"|uniq -c |sort -r -n  
}
main(){
case "$1" in
     word)
        words
     ;;
     letter)
        letters
     ;;
     *)
     echo "USEGE:$0 {word|letter}"
esac
}
main $*
