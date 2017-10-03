#!/bin/sh
#write by luoysx
lamp(){
clear
cat << AA
##################################
#choose number to install program#
##################################
#       1.install  apache        #
#       2.install  mysql         #
#       3.install  php           #
#       4.install  one-click     #
#       5.quit the menu          #
##################################
AA
read -p "Pls input a number(1-5):" b
if [ $b -eq 1 ];then
   echo "apache install."
   sleep 5
   lamp
elif [ $b -eq 2 ];then
   echo "mysql install."
   sleep 5
   lamp
elif [ $b -eq 3 ];then
   echo "php install."
   sleep 5
   lamp
elif [ $b -eq 4 ];then
   echo "lamp install"
   sleep 5
   lamp
elif [ $b -eq 5 ];then
   clear
   main
elif [ "$b ! -eq 1" -o "$b ! -eq 2" -o "$b ! -eq 3" -o "$b ! -eq 4" -o "$b ! -eq 5" ];then
    lamp
fi
}

main(){
clear
cat << AA
##################################
#choose number to install program#
##################################
#       1.install  lamp          #
#       2.install  lnmp          #
#       3.quit the menu          #
##################################
AA
read -p "Pls input a number(1-3):" a
if [ $a -eq 1 ];then
    lamp
elif [ $a -eq 2 ];then
   echo "lnmp install."
elif [ $a -eq 3 ];then
   echo "quit."
elif [ "$a ! -eq 1" -o "$a ! -eq 2" -o "$a ! -eq 3" ];then
#while [ "$a ! -eq 1" -o "$a ! -eq 2" -o "$a ! -eq 3" ];do
    main
#done
fi
}
main
