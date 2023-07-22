#!/bin/bash

NAMING=$3
FULLNAME=$(echo $5 | sed 's/\./ /') 
FILENAME=$(echo $FULLNAME | awk '{print $1}')
EXTENSION_NAME=$(echo $FULLNAME | awk '{print $2}')

MATCH_FOLDER_NAME="^[a-zA-Z]*$"
MATCH_EXT_NAME="^[a-zA-Z]*$"
MATCH_NUM="^[\+-]?[0-9]*$"
MATCH_FILE_NAME="^[A-Za-z]+((\.[a-zA-Z]{1,3}$)|$)"
MATCH_FILE_NUM="^[\+]?[0-9]*[\.]?[0-9]+$"

E_BADARGS=0

#general
[[ $# -ne 6 ]] && { echo "There are unspecified arguments">&2; E_BADARGS=65; }
#first arg
! [[ -d $1 ]] && { echo "WRONG PATH">&2; E_BADARGS=65; }
#second arg
( ! [[ "$2" =~ $MATCH_NUM ]] || [[ $2 -lt 1 ]] ) && { echo "WRONG SUBFOLDERS NUMBER">&2; E_BADARGS=65; }
#third arg
( ! [[ "$NAMING" =~ $MATCH_FOLDER_NAME ]] || [[ ${#NAMING} -gt 7 ]] ) && \
    { echo "WRONG FOLDER NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
# #fourth arg
! [[ "$4" =~ $MATCH_NUM ]] || [ $4 -lt 1 ] && { echo "WRONG FILES NUMBER">&2; E_BADARGS=65; }
# #fifth arg
! [[ "$5" =~ $MATCH_FILE_NAME ]] && \
    { echo "WRONG FILE/EXT NAMING: only latin letters, \
no more than 7 for name, no more than 3 for extension">&2; E_BADARGS=65; }
( [[ ${#FILENAME} -gt 7 ]] || ! [[ "$FILENAME" =~ $MATCH_FOLDER_NAME ]] || [[ ${#FILENAME} -lt 1 ]] ) && \
    { echo "WRONG FILE NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
( [[ ${#EXTENSION_NAME} -gt 3 ]] || ! [[ "$EXTENSION_NAME" =~ $MATCH_EXT_NAME ]] ) && \
    { echo "WRONG EXTENSION NAMING: only latin letters, no more than 3">&2; E_BADARGS=65; }
#six arg
#  ( ! [[ $6 =~ $MATCH_FILE_NUM ]] || (( $(echo "$6 > 100" | bc -l) )) ) && \
#     { echo "WRONG FILE SIZE">&2; E_BADARGS=65; }
#-----------------------------------------------------------
#  the code above is for decimal nums but user can pass
#+ decimal num that does not integer num
#+ in bytes. therefore only integers are permitted.
#-----------------------------------------------------------
 ( ! [[ $6 =~ $MATCH_NUM ]] || (( $(echo "$6 > 100" | bc -l) )) ) && \
    { echo "WRONG FILE SIZE">&2; E_BADARGS=65; }


