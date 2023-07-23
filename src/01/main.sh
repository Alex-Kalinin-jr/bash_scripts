#!/bin/bash
source conditions.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

function create_one_time ()
{
    cd $7
    FOLDERNAME=$1
    FILECOUNT=$2
    NEWFILENAME=$3
    START_FOLDER_COUNT=$4
    REGNAMING=$5
    REGFILENAME=$6
    DIR_PATH=$7

    FILE_FORMER=${REGFILENAME:0:1}
    FOLDER_FORMER=${REGNAMING:0:1}


    for (( y=1; y<=$FILECOUNT; y++ )); do
        FREE_SPACE=$(df -B G / | awk '{print $4}' | sed -e 's/G//')
        FREE_SPACE=$(echo $FREE_SPACE | awk '{print $2}' | sed -n '$p')
        [[ $FREE_SPACE -lt 1 ]] && return #end condition for loop
        truncate -s $8'K' $NEWFILENAME
        EXISTING=$(echo $PWD)
        FOR_LOG=$(echo $NEWFILENAME | sed -e 's/$/'_$8'/')
        FOR_LOG=$(echo | awk -v ONE=$NEWFILENAME -v TWO=$EXISTING '{print ONE"_"TWO}')
        echo $FOR_LOG >> $LOG_LOCATION
        NEWFILENAME=$(echo $NEWFILENAME | \
            sed 's/'$FILE_FORMER'/'$FILE_FORMER''$FILE_FORMER'/')
    done

    [[ $4 -eq 0 ]] && return #end condition for recursy

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | \
            sed 's/'$FOLDER_FORMER'/'$FOLDER_FORMER''$FOLDER_FORMER'/')
        (( START_FOLDER_COUNT-- ))
        mkdir $FOLDERNAME
        create_one_time $FOLDERNAME $2 $NEWFILENAME \
            $START_FOLDER_COUNT $5 $6 $FOLDERNAME $8
    done    
}


SCRIPT_DATE=$(date +"%d%m%y")
NAME_WITH_DATE=$(echo $5 | sed 's/$/'_$SCRIPT_DATE'/')
LOG_LOCATION="$1/file.log"
touch $LOG_LOCATION
create_one_time $NAMING $4 $NAME_WITH_DATE $2 $NAMING $FILENAME $1 $6