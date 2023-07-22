#!/bin/bash
source main.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

function create_one_time ()
{
    cd $7
    FOLDERNAME=$1
    FILECOUNT=$2
    NEWFILENAME=$3
    echo "newfilename = $NEWFILENAME"
    START_FOLDER_COUNT=$4
    REGNAMING=$5
    REGFILENAME=$6
    DIR_PATH=$7

    FILE_FORMER=${REGFILENAME:0:1}
    FOLDER_FORMER=${REGNAMING:0:1}


    for (( y=1; y<=$FILECOUNT; y++ )); do
        touch $NEWFILENAME
        NEWFILENAME=$(echo $NEWFILENAME | sed 's/'$FILE_FORMER'/'$FILE_FORMER''$FILE_FORMER'/')
        echo $NEWFILENAME
    done

    [[ $4 -eq 0 ]] && return #end condition for recursy

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | sed 's/'$FOLDER_FORMER'/'$FOLDER_FORMER''$FOLDER_FORMER'/')
        (( START_FOLDER_COUNT-- ))
        mkdir $FOLDERNAME
        create_one_time $FOLDERNAME $2 $NEWFILENAME $START_FOLDER_COUNT $5 $6 $FOLDERNAME
    done    
}

create_one_time $NAMING $4 $5 $2 $NAMING $FILENAME $1