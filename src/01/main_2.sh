#!/bin/bash
source main.sh

test $E_BADARGS -eq 65 && exit $E_BADARGS

function create_one_time ()
{
    [[ $4 -eq 0 ]] && return
    FOLDERNAME=$1
    FILECOUNT=$2
    NEWFILENAME=$3
    START_FOLDER_COUNT=$4
    II=$5 #FOR FORMING OF NAME
    JJ=$6 #FOR FOMING OF FOLDER NAME
    REGNAMING=$7
    REGFILENAME=$8
    
    FOLDER_FORMER=${REGNAMING:$JJ:(( $JJ + 1 ))}
    FILE_FORMER=${REGFILENAME:$II:(( $II + 1 ))}
    (( JJ++ ))
    (( II++ ))

    for (( y=1; y<=$FILECOUNT; y++ )); do
        # touch "$NEWFILENAME"
        echo $NEWFILENAME
        NEWFILENAME=$(echo $NEWFILENAME | sed 's/'$FILEFORMER'/'$FILEFORMER$FILEFORMER'/')
    done

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | sed 's/'$FOLDERFORMER'/'$FOLDERFORMER$FOLDERFORMER'/')
        echo $FOLDERNAME
        (( START_FOLDER_COUNT=$START_FOLDER_COUNT-1 ))
        # create_one_time $FOLDERNAME $2 $NEWFILENAME $START_FOLDER_COUNT $II $JJ $7 $8
    done    
}

cd $1
create_one_time $NAMING $4 $5 $2 0 0 $NAMING $FILENAME
