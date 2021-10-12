#! /usr/bin/
# CREATED BY: Name
# Date created: todays
# Version 2

# this script is designed to gather system statistics
AUTHOR="Seb"
VERSION="2"
RELEASED="2021-10-05"


# Display help message

USAGE(){
	echo -e $1
	echo -e "\nUsage: systemStats [-t temperature] [-i ipv4 address]"
	echo -e "\t\t  [-v version]"
	echo -e "\t\t  more information see man systemStats"
}

# check for arguments (error checking)
if [ $# -lt 1 ];then
	USAGE "Not enough arguments"
	exit 1
elif [ $# -gt 3 ];then 
	USAGE "Too many argurmnets supplied"
	exit 1
elif [[ ( $1 == '-h' ) || ( $1 == '--help'  ) ]];then
	USAGE "Help!"
	exit 1
fi

# frequently a scripts are written so that arguments can b passed in any order using 'flags'
# With the flags method, some of the arguments can be made manadatory or optional
# a:b (a is mandatory, b is optional) abc is all optional

while getopts tiv OPTION
do
case ${OPTION}
in
i) IP=$(ifconfig wlan0 | grep -w inet | awk '{print$2}')
   echo ${IP};;
t) TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
   echo ${TEMP} "need to divide by thousand...";;
v) echo -e "systemStats:\n\t   Version: ${VERSION} Released: ${RELEASED} Author: ${AUTHOR}";;
esac
done


# end of script 
