#!/bin/bash

NAMING=$3
MATCH_NAME="^[a-zA-Z]*$"
MATCH_EXT_NAME="^[a-zA-Z]*$"
MATCH_NUM="^[+-]?[0-9]*$"
MATCH_FILE_NAME="^[A-Za-z]+((\.[a-zA-Z]{1,3}$)|$)"
CHECK=0
#general
if [ $# -ne 6 ]; then
    CHECK=1
    echo "There are unspecified arguments">&2
fi
#first arg
if ! [ -d $1 ]; then
    CHECK=1
    echo "Specified path is not a directory">&2
fi
#second arg
if ! [[ "$2" =~ $MATCH_NUM ]] || [ $2 -lt 1 ]; then
    CHECK=1
    echo "the second argument must be a positive num">&2
fi
#third arg
if [ ${#NAMING} -gt 7 ]; then
    CHECK=1
    echo "Too large count of naming letters">&2
fi
if ! [[ "$NAMING" =~ $MATCH_NAME ]]; then
    CHECK=1
    echo "only letters are permitted for naming">&2
fi
#fourth arg
if ! [[ "$4" =~ $MATCH_NUM ]] || [ $4 -lt 1 ] ; then
    CHECK=1
    echo "the fourth argument must be a positive num">&2
fi
#fifth arg
#first check - general compatibility
if ! [[ "$5" =~ $MATCH_FILE_NAME ]]; then
    CHECK=1
    echo "WRONG NAMING: only latin letters, no more than 7 for name, no more than 3 for extension"
fi
FULLNAME=$(echo $5 | sed 's/\./ /') 
FILENAME=$(echo $FULLNAME | awk '{print $1}')
EXTENSION_NAME=$(echo $FULLNAME | awk '{print $2}')
if [ ${#FILENAME} -gt 7 ] || ! [[ "$FILENAME" =~ $MATCH_NAME ]] || [ ${#FILENAME} -lt 1 ]; then
    CHECK=1
    echo "WRONG NAMING: only latin letters, no more than 7"
fi
echo "file name is $FILENAME"
echo "ext name is $EXTENSION_NAME"
if [ ${#EXTENSION_NAME} -gt 3 ] || ! [[ "$EXTENSION_NAME" =~ $MATCH_EXT_NAME ]]; then
    CHECK=1
    echo "WRONG NAMING: only latin letters, no more than 3"
fi

#six arg
test $CHECK -eq 0 && echo "all right" || echo "smthg goes wrong"


