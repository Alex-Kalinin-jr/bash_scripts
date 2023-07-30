#!/bin/bash

source conditions.sh
source ../creation_func.sh

! test $E_BADARGS -eq 0 && exit $E_BADARGS

! [[ -f $(echo "/err.log") ]] && touch /err.log

if [[ $1 -eq 1 ]]; then
    read -p "write log file location (absolute path): " LOG_LOCATION; 
    ( [[ -f $1 ]] && cat $1 >/dev/null ) && \
        { echo "WRONG PATH">&2; E_BADARGS=65; exit $E_BADARGS; }  
    while read line
    do
        TO_DEL=$(echo $line | awk 'BEGIN { FS = "_" } ; {print substr($3, $NF)"/"$1"_"$2}')
        rm -f "$TO_DEL" 2>/err.log
    done < $LOG_LOCATION
fi

exit $E_BADARGS;