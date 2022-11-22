#! /usr/bin/env bash

TEMPERATURESTATS()
{
  DIVIDE=1000
  #TEMPS=$(cat /sys/class/thermal/thermal_zone*/temp | sort -n)
  TEMPS=$(echo  50000 15500 54660 | sort -n)
  ############# STATISTICS #################

  MIN=${TEMPS[0]}
  MAX=0

  for T in ${TEMPS[@]}
  do
	  if [[ ${T} > ${DIVIDE} ]]; then
		  T=$( echo 'scale=2;'"${T}" | bc -l )
		  SUM=$(( ${SUM} + ${T} ))
		  SIZE=$(( ${SIZE} + 1 ))
		  if [[ ${MAX} < ${T} ]]; then
			  MAX=${T}
		  fi

		  if [[ ( ${MIN} > ${T} ) && ( ${T} > 0  ) ]]; then
			  MIN=${T}
		  fi

		  fi
	  done

	  AVGTEMP=$( awk " BEGIN { printf ( ${SUM} / ${SIZE} / ${DIVIDE} ) } " | awk '{ printf "%2.2f\n", $0 }' )


 # Calculate Median
 if [[ $(( ${SIZE} % 2 )) == 0 ]]; then
	 MIDDLE=$(( ${SIZE} / 2 ))
 else
	 MIDDLE=$(( ( ${SIZE} + 1 ) / 2 ))
 fi

 TMP=$( echo ${TEMPS[@]} | awk -v POS="${MIDDLE}" '{ print $POS }' )

 MEDIAN=$( awk " BEGIN { printf ( ${TMP} / ${DIVIDE} ) } "  | awk '{ printf "%2.2f\n",$0 }' )

 MIN=$( awk " BEGIN { printf ( ${MIN} / ${DIVIDE} ) }" |  awk '{ printf "%2.2f\n",$0 }' )
 MAX=$( awk " BEGIN { printf ( ${MAX} / ${DIVIDE} ) }" |  awk '{ printf "%2.2f\n",$0 }' )

 echo "Min: " ${MIN} "Max: " ${MAX}  "Avg: " ${AVGTEMP} "Med:" ${MEDIAN}

}
TEMPERATURESTATS
