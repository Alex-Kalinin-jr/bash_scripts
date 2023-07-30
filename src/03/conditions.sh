#!/bin/bash

source ../regexps.sh
source ../creation_func.sh

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
    check_and_compare_2_dates $2 $3 $4 $5;
    [[ $(echo $?) -eq 0 ]] || exit $E_BADARGS
    }
