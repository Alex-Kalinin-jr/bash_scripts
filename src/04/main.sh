#! /bin/bash

source ../regexps.sh
source values_generator.sh
source arrays.sh

URLS_FILE="sites_list.txt"
AGENTS_FILE="user_agents.txt"

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
        "${NEW_TIME}" "${NEW_PROTO}" "${NEW_URL}" "${NEW_AGENT}"
        