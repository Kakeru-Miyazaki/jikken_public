#!bin/bash
# cd ~/fefss
echo -e '\e[1m'
./menu.out
ipnum=$?
ip=`head -$ipnum data/ipdata.txt | tail -1 | awk '{ print $2 }'`
./menu2.out
num=$?

clear
if test $num = "0"; then
 ./client_recv.out $ip 50000
else
 ./client_recv2.out $ip 50000
fi


#./client_recv.out $ip 50000
