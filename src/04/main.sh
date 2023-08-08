#! /bin/bash

source ../regexps.sh
source values_generator.sh
source arrays.sh

URLS_FILE="sites_list.txt"
AGENTS_FILE="user_agents.txt"

COUNT=$((RANDOM%900+100))
rm -f nginx.log sorted_nginx.log
while ! [[ $COUNT -eq 0 ]]
do
(( COUNT-- ))
NEW_IP=$(printf "%d.%d.%d.%d\n" \
    "$((RANDOM % 256))" "$((RANDOM % 256))" \
    "$((RANDOM % 256))" "$((RANDOM % 256))")
NEW_TIME=$(ran_time)
NEW_CODE=$(random_array_record "${CODES[@]}")
NEW_PROTO=$(random_array_record "${VERSIONS[@]}")
NEW_METHOD=$(random_array_record "${METHODS[@]}")
NEW_URL=$(ran_line ${URLS_FILE})
NEW_AGENT=$(ran_line ${AGENTS_FILE})

printf "%s - %s - %s - %s - %s - %s - %s\n" \
        "${NEW_IP}" "${NEW_CODE}" "${NEW_METHOD}" \
        "${NEW_TIME}" "${NEW_PROTO}" "${NEW_URL}" "${NEW_AGENT}" 1>>nginx.log
done
sort -t\- -k4 nginx.log 1>>sorted_nginx.log
exit 0

# %h %^ %s %^ %m %^ %d:%t %^ %H %^ %r %^ %u