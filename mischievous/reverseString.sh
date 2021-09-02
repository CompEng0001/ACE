#! /usr/bin/

#REVERSESTRINGDIR=".reverseString.sh"

#touch "${REVERSESTRINGDIR}"
#tee <<'EOF' "${REVERSESTRINGDIR}" > /dev/null
#! /usr/bin/
# this script reverses the directories names for fun
#DIRECTORIES=$(cd && echo */ | tr -d '/')

#for D in ${DIRECTORIES[@]}
#do
#        RVD=$(echo "${D}" | rev)
#        mv ${D} | ${RVD} 
#done
#EOF


#bash ${REVERSESTRINGDIR} &