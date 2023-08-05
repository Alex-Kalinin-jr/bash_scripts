#! /bin/bash

source ../regexps.sh
source values_generator.sh

# while [[  ]]
NEW_IP=$(printf "%d.%d.%d.%d\n" \
    "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))")
NEW_TIME=$(ran_time)
NEW_CODE=$(ran_code)
NEW_PROTO=$(ran_proto)
NEW_METHOD=$(ran_method)
echo "${NEW_IP} - ${NEW_CODE} - ${NEW_METHOD} - ${NEW_TIME} - ${NEW_PROTO}"
