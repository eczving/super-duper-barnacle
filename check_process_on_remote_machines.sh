#!/bin/bash

${HOSTNAME?}
hostnames=("remote_machine1" "remote_machine2" "remote_machine3" "remote_machineN")

# Process status on host machine
if [[ $(ps aux | grep process | grep -vc grep)  > 0 ]] ; then echo $HOSTNAME process OK; else echo $HOSTNAME process not OK ; fi

tLength=${#hostnames[@]}

# Process status for other machines
# The local machine must have access to the remote ones. SSH keypairs are preferred for security reasons.
for (( i=0; i<=${tLength}; i++ ));
do
        ssh user@${hostnames[i]} 'if [[ $(ps aux | process | grep -vc grep)  > 0 ]] ; then echo $HOSTNAME process is OK; else echo $HOSTNAME process not OK  ; fi'
done
