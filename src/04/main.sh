#! /bin/bash

URLS_FILE="sites_list.txt"

source ../regexps.sh
source values_generator.sh

URL_LINES=$(wc -l ${URLS_FILE} | awk '{print 1}')
echo ${URL_LINES}

# while [[  ]]
NEW_IP=$(printf "%d.%d.%d.%d\n" \
    "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))")
NEW_TIME=$(ran_time)
NEW_CODE=$(ran_code)
NEW_PROTO=$(ran_proto)
NEW_METHOD=$(ran_method)
echo "${NEW_IP} - ${NEW_CODE} - ${NEW_METHOD} - ${NEW_TIME} - ${NEW_PROTO}"
