#!/bin/bash
#01
source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

LOG_LOCATION="/file_1.log"
touch $LOG_LOCATION
# the first NAMING is recursively changed folder name and 
#+the 3nd arg is absoliute path at start and (o_O) created folder name
#+inside recursy for deep diving
create_one_time "$REGNAMING" "K" "$1"
