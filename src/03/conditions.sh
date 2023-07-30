#!/bin/bash

source ../regexps.sh

E_BADARGS=0

#arg count
( ! [[ $(echo $#) -eq 1 ]] && ! [[ $(echo $#) -eq 5 ]] ) \
    && { echo "smth goes wrong"; exit 1; }
#first arg
( ! [[ $1 -eq 1 ]] && ! [[ $1 -eq 2 ]] && ! [[ $1 -eq 3 ]] ) \
    && { echo "smth goes wrong"; exit 1; }
#5 args case
( [[ $1 -eq 3 ]] && [[ $(echo $# -eq 5) ]] ) && \
    {
        ( date --date="$2 $3" "+%d-%m-%Y %H:%M start" 2> /dev/null && \
        date --date="$4 $5" "+%d-%m-%Y %H:%M end" 2> /dev/null ) || \
        echo "WRONG DATE TIME FORMAT: should be YYYY/MM/DD and HH:MM"; 
     }

