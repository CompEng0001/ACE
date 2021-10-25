#! /usr/bin/env bash

# Downgrade wpa_supplicant on BUSTER
# Connect via Ethernet of WIFI before doing this...

echo "Checking for connection..."
IP=$(hostname -I)
if [[ -z ${IP} ]];then
	echo "You are not connected to the internet, exiting script the outcome would be fatal."
	exit 1
else 
	echo "...have connection to the internet"
fi

echo "Continuing will download over 50MB of data minimum, [Y,n]"
read INPUT
if [ ${INPUT} == 'n' ];then
	echo "exiting script, bye!"
	exit 0
fi


PACKAGE="wpasupplicant"
ORIGINAL="/etc/apt/sources.list"
BACKUP="/etc/apt/sources.list.bak"

sudo apt-get remove ${PACKAGE} -y
sudo mv -f ${ORIGINAL} ${BACKUP}
sudo bash -c "echo 'deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list"
sudo apt-get install ${PACKAGE} -y
sudo apt-mark hold ${PACKAGE}
sudo cp -f ${BACKUP} ${ORIGINAL}
sudo apt-get update

echo "run this on after boot up, sudo wpa_cli wlan0 select_network 1"
echo "rebooting"
sudo reboot

#END OF SCRIPT
