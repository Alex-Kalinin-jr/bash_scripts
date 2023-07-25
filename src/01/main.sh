#!/bin/bash
#01
source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

LOG_LOCATION="$1/file.log"
touch $LOG_LOCATION
# the first NAMING is recursively changed folder name and the 2nd
#+is regpattern for first NAMING evolution.
#+six arg is absoliute path at start and (o_O) created folder name
#+inside recursy for deep diving
create_one_time $NAMING $4 $2 $NAMING $FILENAME $1 $6 K
