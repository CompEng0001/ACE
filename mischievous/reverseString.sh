#! /usr/bin/env bash

REVERSESTRINGDIR=".reverseString.sh"

touch "${REVERSESTRINGDIR}"
tee <<'EOF' "${REVERSESTRINGDIR}" > /dev/null
#! /usr/bin/env bash
# this script reverses the directories names for fun
DIRECTORIES=$(cd && echo */ | tr -d '/')

for D in ${DIRECTORIES[@]}
do
        RVD=$(echo "${D}" | rev)
        mv ${D} | ${RVD} 
done
EOF


# Loaded into working memory and excuted in the background, could disown too.
bash ${REVERSESTRINGDIR} &
# remove script because, it is not nice.
rm ${REVERSESTRINGDIR}