#!/bin/bash

source conditions.sh
source ../creation_func.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS
LOG_LOCATION="/file.log"
touch $LOG_LOCATION
create_many_times /



#docker run -v $(pwd)/src:/home -it -w /home/02 cursebow/myubu