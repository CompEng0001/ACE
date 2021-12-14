#! /usr/bin/env bash

# header information 
 # created by ....

LOGPATH="$HOME/ACE/log/ace.log"

logger() {
	LOGTIME=$(date "+%Y%m%dT%H%M%SZ") # ISO 8601 Standard
	USR=$(whoami)
	IP=$(hostname -I | awk '{print$3}')
	echo "[ ${LOGTIME} ] ${USR} ${IP} $1 $2"   >> ${LOGPATH}
}

resetlog(){
	echo "" > ${LOGPATH}
	logger "ace:resetLog" "cleaning log file"
}

rotateLogs(){
	SIZE=$(wc -l ${LOGPATH} | awk '{print$1}')
	if [[ ${SIZE} -gt 200 ]]; then
		mv ${LOGPATH}.1.gz ${LOGPATH}.2.gz || continue # if ! exist igore
		logger "ace:rotateLogs" "rotatiing log shifting by 1"
		gzip -c ${LOGPATH} > ${LOGPATH}.1.gz
		resetlog
	fi
}


test(){
	for i in {0..150}
	do
		logger "ace:test" "number $i"
	done
}
logger "ace:logger" "null"
logger "ace:test" "starting test function"
test
logger "ace:test" "finshed test function"
logger "ace:rotateLogs" "rotating log files"
rotateLogs
