#!/bin/bash
#locks multiple users on machines


${HOSTNAME?}
hostnamee=("machine1" "machine2" "machine3")

tLen=${#hostnamee[@]}

for (( i=0; i<=${tLen}; i++ ));
do
       ssh ${hostnamee[i]} 'usermod --lock --expiredate <date in year-month-day format> <username>;usermod --lock --expiredate <date in year-month-day format> <username2>'
done
