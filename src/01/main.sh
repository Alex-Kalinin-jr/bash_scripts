#!/bin/bash
#01
source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

SCRIPT_DATE=$(date +"%d%m%y")
NAME_WITH_DATE=$(echo $5 | sed 's/$/'_$SCRIPT_DATE'/')
LOG_LOCATION="$1/file.log"
touch $LOG_LOCATION
create_one_time $NAMING $4 $NAME_WITH_DATE $2 $NAMING $FILENAME $1 $6 K