#!/bin/bash
echo -e '\e[1m'
./menu2.out
num=$?
clear
if test $num = "0"; then
 ./serv_send.out 50000
else
 ./serv_send2.out 50000
fi


