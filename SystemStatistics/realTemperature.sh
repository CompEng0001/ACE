#!/usr/bin

# this script returns all the temperature values and thermal zones.
function twoDP() { awk "BEGIN{print $*}"; }

function thermalZones()
{
    echo paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t
}

function TemperatureStats()
{
    DIVIDE=1000
    TEMPS=$(cat /sys/class/thermal/thermal_zone*/temp | sort -n)
    ############### STATISTICS ##############
    MIN=100000
    MAX=0
    
    for T in ${TEMPS[@]}
    do
        if [[ ${T} > ${DIVIDE} ]] ; then 
            T=$(( echo "scale=2; ${T}" | bc ))
            SUM=$(( ${SUM} + ${T} ))
            SIZE=$(( ${SIZE} + 1 ))
            if [[ ${MAX} < ${T}  ]] ; then
                MAX=${T}
            fi
            if [[ ( ${T} -lt ${MIN} ) && ( ${T} -gt 0 ) ]] ; then
                MIN=${T}
            fi
        fi
    done
    AVGTEMP=$( ( awk "BEGIN { print ( $SUM / $SIZE / $DIVIDE) }" | awk '{printf "%2.2f\n",$0}' ) )

    #Calculate the Median
    if  [[ $((${SIZE} % 2)) == 0 ]] ; then
        MIDDLE=$(( ${SIZE}/2 ))
        TMP=$(echo ${TEMPS[@]} | awk -v POS="${MIDDLE}" '{print $POS}')
        MEDIAN=$(( echo ${TMP} / ${DIVIDE} | awk '{printf "%2.2f\n",$0}'))
    fi    

    echo "Min =" ${MIN} " Max =" ${MAX} "Avg =" ${AVGTEMP} "Med =" ${MEDIAN}
}

# invoke the function
TemperatureStats