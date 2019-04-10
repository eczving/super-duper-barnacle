#!/bin/bash
  
LIMIT='80'
DIR='/var/log/audit'
PROCESS='detectd'

if [[ ! $(pidof $PROCESS) ]]; then
     exit 0
     
fi


oesVersion=$( cat /etc/novell-release | grep VERSION | cut -d= -f2 |sed -e 's/^[ \t]*//' |cut -d\. -f1 )

#To check real used size, we need to navigate to folder

USED=`df ${DIR} | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`

#This line will get used space of partition where we currently, this will use df command, and get used space in %, and after cut % from value.


if [ ${USED} -gt ${LIMIT} ] && [ $oesVersion == "11" ]

#If used space is bigger than LIMIT

then

        /etc/init.d/${PROCESS} stop;echo "detectd was killed by script" | logger -p local0.warn;
fi



if [ $USED -gt $LIMIT ] && [ $oesVersion == "2015" ]

#If used space is bigger than LIMIT

then

        /etc/init.d/${PROCESS} stop;echo "detectd was killed by script" | logger -p local0.warn;
fi



if [ $USED -gt $LIMIT ] && [ $oesVersion == "2018" ]

#If used space is bigger than LIMIT

then

        /etc/init.d/${PROCESS} stop;echo "detectd was killed by script" | logger -p local0.warn;
fi

