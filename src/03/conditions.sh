#!/bin/bash

source ../regexps.sh

E_BADARGS=0

#arg count
( ! [[ $(echo $#) -eq 1 ]] && ! [[ $(echo $#) -eq 5 ]] ) \
    && { echo "smth goes wrong"; exit 1; }
#first arg
( ! [[ $1 -eq 1 ]] && ! [[ $1 -eq 2 ]] && ! [[ $1 -eq 3 ]] ) \
    && { echo "smth goes wrong"; exit 1; }
( [[ $1 -eq 3 ]] && [[ $(echo $# -eq 5) ]] ) && \
    { DATE_START=$(echo $2); \
    d=${DATE_START:0:2}; \
    m=${DATE_START:3:5}; \
    Y=${DATE_START:6:10}; \
    echo "mont=$m"
    if date -d "$Y-$m-$d" &> /dev/null; then echo VALID; else echo INVALID; fi; }
