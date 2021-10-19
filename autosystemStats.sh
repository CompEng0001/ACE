#! /usr/bin/env bash
# CREATED BY: Name
# Date created: todays
# Version 2

# this script is designed to gather system statistics
AUTHOR="Seb"
VERSION="1"
RELEASED="2021-10-19"
FILE=~/ACE/systemstats.log
# Display help message

USAGE(){
	echo -e $1
	echo -e "\nUsage: systemStats [-v version]"
	echo -e "\t\t  more information see man systemStats"
}

# check for arguments (error checking)
if [ $# -gt 1 ];then
	USAGE "Not enough arguments"
	exit 1
elif [[ ( $1 == '-h' ) || ( $1 == '--help'  ) ]];then
	USAGE "Help!"
	exit 1
elif [[ $1 == '-v' ]]; then
	echo -e "systemStats:\n\t   Version: ${VERSION} Released: ${RELEASED} Author: ${AUTHOR}"
	exit 1
fi

# variables to hold system information
IP=$(ifconfig wlan0 | grep -w inet | awk '{print$2}')
USAGE=$(grep -w 'cpu' /proc/stat | awk '{usage=($2+$3+$4+$6+$7+$8)*100/($2+$3+$4+$5+$6+$7+$8)}
					   {free=($5)*100/($2+$3+$4+$5+$6+$7+$8)} 
					    END {printf " Used CPU: %.2f%%",usage}
					        {printf " Free CPU: %.2f%%",free}')
TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
NOW=$(date +%Y-%m-%dT%H:%M:%SZ)

# output to log file
echo -e "${NOW}\tIP: ${IP} Temperature: ${TEMP} CPU: ${USAGE}" >> ${FILE}
# end of script 
