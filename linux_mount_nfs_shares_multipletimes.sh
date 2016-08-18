#!/usr/local/bin/bash
set -x
#tsms=`seq - 1 10`
#loopCount=`seq - 1 5`
dir=10
count=200
for i in $(seq 1 5);      ##$loopCount
do
    
    for j in $(seq 1 10); #number of nfs shares IP's   
    do
       tsmip=`expr $count + $j`
       showmount -e 16.10.26.$tsmip | cut -d ' ' -f 1| grep e_silicon > temp
        while read line
        do
         mkdir -p /mnt$line$i$j
         mount -o acdirmin=0,acdirmax=0,acregmin=0 16.10.26.$tsmip:$line /mnt$line$i$j
        sleep 1
        done < temp


        if [ $? -ne 0 ]; then
            exit 1;
        fi
        done
done
