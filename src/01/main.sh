#!/bin/bash

NAMING=$3
MATCHNAME="^[a-zA-Z]*$"
MATCHNUM="^[+-]?[0-9]*$"
MATCHFILENAME="^[A-Za-z]+((\.[a-zA-Z]{1,3}$)|$)"
CHECK=0
#general
if [ $# -ne 6 ]; then
    CHECK=1
    echo "There are unspecified arguments"
fi
#first arg
if ! [ -d $1 ]; then
    CHECK=1
    echo "Specified path is not a directory"
fi
#second arg
if ! [[ "$2" =~ $MATCHNUM ]] || [ $2 -lt 1 ]; then
    CHECK=1
    echo "the second argument must be a positive num"
fi
#third arg
if [ ${#NAMING} -gt 7 ]; then
    CHECK=1
    echo "Too large count of naming letters"
fi
if ! [[ "$NAMING" =~ $MATCHNAME ]]; then
    CHECK=1
    echo "only letters are permitted for naming"
fi
#fourth arg
if ! [[ "$4" =~ $MATCHNUM ]] || [ $4 -lt 1 ] ; then
    CHECK=1
    echo "the fourth argument must be a positive num"
fi


#fifth arg - TO BE REWRITTEN WITH SEPARATED CHECKS!
FULLNAME=$5
echo $FULLNAME
IFS='.'
FILENAME=$(echo "$FULLNAME" | awk '{print $1}')
echo $FILENAME
# if [ ${#FILENAMING} -gt 7 ]; then
#     CHECK=1
#     echo "Too large count of file naming letters"
# fi
# if ! [[ "$5" =~ $MATCHFILENAME ]]; then
#     CHECK=1
#     echo "wrong file name format"
# fi
IFS=' '



# test $CHECK -eq 0 && echo "all right" || exit 2
