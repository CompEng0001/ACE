
#! /bin/bash
# Created by: Seb Blair
# Date Created: 27-10-2020
# Verison:  1.3

# this script is designed to gather system statistics

# Display help message
USAGE(){
         echo -e  $1
         echo -e "\nUsage: systemStats [-t temperature] [-f arm frequency] [-c cores] [-v volts]"
         echo -e "\t\t   [-m arm memory] [-M gpu memory] [-f free memory] [-i ipv4/6 address]"
         echo -e "more information see: man systemStats"
}

VERSION="Version: 1.3"
AUTHOR="Author: Seb Blair"
RELEASED="Release Date: 2020-10-27"
FILE="ACE/systemStats.log"

# Check for arguments (error checking)

if [ $# -lt 1 ];then
        USAGE "Not enough arguments"
        exit 1
elif [ $# -gt 8 ]; then
        USAGE "Too many arguments supplied"
        exit 1
elif [[ ( $1 == '--help' ) || ( $1 == '-h' ) ]];then
        USAGE 'Help'
        exit 1
fi

# Frequently a script is written so that arguments can be passed in any order
# using flags. With the flags method, some of the arguments can be made optional

while getopts tfcVmMFiv OPTION
do
case ${OPTION}
in
t) TEMP=$(vcgencmd measure_temp);;
f) ARMCLOCK=$(vcgencmd measure_clock arm );;
c) CORES=$("Cores: "cat /sys/devices/system/cpu/present);;
V) VOLT=$(vcgencmd measure_volts core);;
m) ARMMEM=$(vcgencmd get_mem arm);;
M) GPUMEM=$(vcgencmd get_mem gpu);;
F) FREEMEM=$(free -m );;
i) IP=$(hostname -I | awk '{print $1}');;
v) echo -e "${VERSION} ${RELEASED} ${AUTHOR}";;
*) USAGE "\n${*} argument was not recognised";;
esac
done

if [ ! -e ${FILE} ]; then
        touch ${FILE}
fi

NOW=$(date)
echo ${NOW} "User: "${USER} ${TEMP} ${ARMCLOCK} ${CORES} ${VOLT} ${ARMMEM} ${GPUMEM} ${FREEMEM} ${IP} >> ${FILE}

# end of script