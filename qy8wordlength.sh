#!/bin/sh
#write by luoysx
for i in I am oldboy teacher welcome to oldboy trainingclass
do
   [ ${#i} -le 6 ]&&echo $i
done
