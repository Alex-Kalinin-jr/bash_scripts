#!/bin/bash
#02
source ../regexps.sh

NAMING=$1
FULLNAME=$(echo $2 | sed 's/\./ /') 
FILENAME=$(echo $FULLNAME | awk '{print $1}')
EXTENSION_NAME=$(echo $FULLNAME | awk '{print $2}')
FILE_SIZE=$3

E_BADARGS=0

#first arg
( ! [[ "$NAMING" =~ $MATCH_FOLDER_NAME ]] || [[ ${#NAMING} -gt 7 ]] ) && \
    { echo "WRONG FOLDER NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
#second arg
! [[ "$2" =~ $MATCH_FILE_NAME ]] && \
    { echo "WRONG FILE/EXT NAMING: only latin letters, \
no more than 7 for name, no more than 3 for extension">&2; E_BADARGS=65; }
( [[ ${#FILENAME} -gt 7 ]] || ! [[ "$FILENAME" =~ $MATCH_FOLDER_NAME ]] || [[ ${#FILENAME} -lt 1 ]] ) && \
    { echo "WRONG FILE NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
( [[ ${#EXTENSION_NAME} -gt 3 ]] || ! [[ "$EXTENSION_NAME" =~ $MATCH_EXT_NAME ]] ) && \
    { echo "WRONG EXTENSION NAMING: only latin letters, no more than 3">&2; E_BADARGS=65; }
#third arg
 ( ! [[ $FILE_SIZE =~ $MATCH_NUM ]] || (( $(echo "$FILE_SIZE > 100" | bc -l) )) ) && \
    { echo "WRONG FILE SIZE">&2; E_BADARGS=65; }