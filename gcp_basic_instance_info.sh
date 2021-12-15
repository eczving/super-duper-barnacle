#!/bin/bash
#
#Tested on Debian 9
#

PRIVATE_IP=$(ip a | grep global | awk '{ print $2 }')
MAC=$(ip a | grep ether | awk '{ print $2 }')
#PUBLIC=$(gcloud compute instances describe crdhost1 --zone europe-west1-b | grep -i natip | awk '{ print $2 }')
PUBLIC=$(curl -s -L https://cpanel.net/myip)

DNS=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
GEOLOC=$(curl -s ipinfo.io/$PUBLIC | grep -i city | awk '{print $2}')
USERS=$(grep -i ssh /var/log/auth.log | grep Accepted | tail)
PACKAGESIZE=$(dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 10 | awk '{sum+=$1}; END{print sum;}')

ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/id" -H "Metadata-Flavor: Google")
SERVICE_ACCOUNTS=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/" -H "Metadata-Flavor: Google")
PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")

echo "My private IP is $PRIVATE_IP"
echo "My MAC address is $MAC"
echo "Public IP is $PUBLIC"
echo "My DNS servers are $DNS "
echo "This server is in $GEOLOC"
printf "\n"
echo "List of recently logged in users:"
echo "$USERS"
printf "\n"
echo "Size of all packages installed on this instance is $PACKAGESIZE kilobytes"

echo "Instance ID is $ID"
echo "Service accounts on the instance:" 
echo "$SERVICE_ACCOUNTS"
printf "\n"
echo "Project ID is $PROJECT_ID"
