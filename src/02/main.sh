#!/bin/bash

source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS
SCRIPT_DATE=$(date +"%d%m%y")
NAME_WITH_DATE=$(echo $2 | sed 's/$/'_$SCRIPT_DATE'/')
LOG_LOCATION="/file.log"
touch $LOG_LOCATION
cd /
#single step
LIST=$(ls -d */)
for I in $LIST; do
    [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && continue #condition for restricted folders
    START_FILE_COUNT=$(echo $(( 1+$RANDOM%100 )) )
    echo $I $START_FILE_COUNT $NAME_WITH_DATE 100 $1 $FILENAME $I $3 M 1; echo; echo;
    create_one_time $I $START_FILE_COUNT $NAME_WITH_DATE 100 \
        $1 $FILENAME $I $3 M 1
done


#docker run -v $(pwd)/src:/home -it -w /home/02 cursebow/myubu