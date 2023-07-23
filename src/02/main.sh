#!/bin/bash

source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS
LOG_LOCATION="/file.log"
touch $LOG_LOCATION
cd /
#single step
LIST=$(ls -d */)
for I in $LIST; do
    [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && continue #condition for restricted folders
    create_one_time_var_2 $I $1 $2 $3 $FILENAME
    cd /
done


#docker run -v $(pwd)/src:/home -it -w /home/02 cursebow/myubu