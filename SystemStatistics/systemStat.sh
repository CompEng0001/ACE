#! /usr/bin/bash
# Created by: Seb Blair
# Date Created: 26-09-2021
# Verison:  1.0

# this script is designed to gather system statistics
AUTHOR="Seb Blair"
VERSION="1.0"
RELEASED="2020-09-16"

# Display help message
USAGE(){
         echo -e  $1
         echo -e "\nUsage: systemStats [-t temperature] [-f core frequency] [-c cores] [-V volts]"
         echo -e "\t\t   [-m arm memory] [-M gpu memory] [-f free memory] [-i ipv4 and ipv6 address] "
         echo -e "\t\t   [-v version]"
	 echo -e "\t\t   more information see: man systemStats"
}

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

# Frequently a script is written so that arguments can be passed in any order  using flags.
# With the flags method, some of the arguments can be made optional
# a:b means that a mandatory b is not. abc means they all optional

while getopts tfdDcVmFivu OPTION
do
case ${OPTION}
in
t) TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
   echo ${TEMP};;
f) COREFREQUENCY=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq)
   echo ${COREFREQUENCY};;
c) CORES=$(cat /sys/devices/system/cpu/present)
   echo "cores="${CORES};;
d) DISKSPACE=$(df -H | grep -w 'root' | awk '{print $2}')
   echo "Disk size="${DISKSPACE};;
D) DISKSPACES=$(df -H  | grep -w 'root' | awk '{print "Total Space: "$2 " Used: "$3 " Avail: "$4}')
   echo -e "Disk Info="${DISKSPACES};;
V) VOLT=$(vcgencmd measure_volts core)
   echo ${VOLT};;
u) USAGE=$(grep -w 'cpu ' /proc/stat | awk '{usage=($2+$3+$4+$6+$7+$8)*100/($2+$3+$4+$5+$6+$7+$8)} 
					    {free=($5)*100/($2+$3+$4+$5+$6+$7+$8)} 
					    END {printf "Used Cpu: %.2f%%\n",usage}
                                            {printf "Free Cpu: %.2f%%\n",free}')
   echo -e ${USAGE};;
m) ARMMEM=$(cat /proc/meminfo | grep -w 'MemTotal' | awk '{mem=$2/1000} END {printf "%.0fM",mem}' )
   echo ${ARMMEM};;
F) FREEMEM=$(free -m )
   echo ${FREEMEM};;
i) IP=$(ifconfig wlan0 | grep -w inet | awk '{ print $2 }')
   echo "IP="${IP};;
v) echo -e "systemStats:\n\t   Version: ${VERSION}  Released: ${RELEASED} Author: ${AUTHOR}";;
*) USAGE "\n${*} argument was not recognised";;
esac
done

# end of script
