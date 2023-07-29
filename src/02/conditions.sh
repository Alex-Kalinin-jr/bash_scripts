#!/bin/bash
#02
source ../regexps.sh

REGNAMING=$1
INITIAL_NAME=$2
START_FOLDER_COUNT=100
FULLNAME=$(echo $2 | sed 's/\./ /') 
REGFILENAME=$(echo $FULLNAME | awk '{print $1}')
FILE_FORMER=${REGFILENAME:0:1}
FOLDER_FORMER=${REGNAMING:0:1}
EXTENSION_NAME=$(echo $FULLNAME | awk '{print $2}')
FILESIZE=$3
SCRIPT_DATE=$(date +"%d%m%y")

E_BADARGS=0

#first arg
( ! [[ "$REGNAMING" =~ $MATCH_FOLDER_NAME ]] || [[ ${#REGNAMING} -gt 7 ]] ) && \
    { echo "WRONG FOLDER NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
# second arg
! [[ "$2" =~ $MATCH_FILE_NAME ]] && \
    { echo "WRONG FILE/EXT NAMING: only latin letters, \
no more than 7 for name, no more than 3 for extension">&2; E_BADARGS=65; }
( [[ ${#REGFILENAME} -gt 7 ]] || ! [[ "$REGFILENAME" =~ $MATCH_FOLDER_NAME ]] || [[ ${#REGFILENAME} -lt 1 ]] ) && \
    { echo "WRONG FILE NAMING: only latin letters, no more than 7">&2; E_BADARGS=65; }
( [[ ${#EXTENSION_NAME} -gt 3 ]] || ! [[ "$EXTENSION_NAME" =~ $MATCH_EXT_NAME ]] ) && \
    { echo "WRONG EXTENSION NAMING: only latin letters, no more than 3">&2; E_BADARGS=65; }
#third arg
 ( ! [[ $FILESIZE =~ $MATCH_NUM ]] || (( $(echo "$FILESIZE > 100" | bc -l) )) ) && \
    { echo "WRONG FILE SIZE">&2; E_BADARGS=65; }