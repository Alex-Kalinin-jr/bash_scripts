#!/bin/bash

source conditions.sh

LOG_LOCATION="/file.log"
touch $LOG_LOCATION
cd /
for I in $LIST; do
    # ! [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && 
    echo $I
done
