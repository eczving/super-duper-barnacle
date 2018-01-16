#This script removes a given file or directory or it's contents on multiple machines
#The script is based on an improved version of check_process_on_remote_machines.sh

#!/bin/bash


parameter="$1" #expects parameter from command line

machines=("machine name1" "machine name2" )

tLength=${#machines[@]}

rm -frv ${parameter:?};

if [ ! -f "$parameter" ];then
        echo "$parameter successfully deleted or does not exist on $HOSTNAME"
fi


for (( i=0; i<=${tLength}; i++ ));
do
        ssh -t ${machines[i]} "rm -frv ${parameter:?}; echo -e $? $machines; echo """

done

