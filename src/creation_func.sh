function create_one_time ()
{
    cd $6
    SCRIPT_DATE=$(date +"%d%m%y")
    NEWNAME=$(echo | awk -v A=$5 -v B=$9 '{print A"."B}')
    FILECOUNT=$2
    FILESIZE=$7

    FOLDERNAME=$1
    START_FOLDER_COUNT=$3
    
    REGNAMING=$4
    REGFILENAME=$5
    FILE_FORMER=${REGFILENAME:0:1}
    FOLDER_FORMER=${REGNAMING:0:1}

    for (( y=1; y<=$FILECOUNT; y++ )); do
        FREE_SPACE=$(df -B G / | awk '{print $4}' | sed -e 's/G//')
        FREE_SPACE=$(echo $FREE_SPACE | awk '{print $2}' | sed -n '$p')
        [[ $FREE_SPACE -lt 1 ]] && return #end condition for loop

        truncate -s $FILESIZE"$8" $NEWNAME 2>/dev/null
        NAME_WITH_DATE=$(echo $NEWNAME | sed 's/$/'_$SCRIPT_DATE'/')
        if [[ $(echo $?) -eq 0 ]]; then
            EXISTING=$(echo $PWD)
            FOR_LOG=$(echo $NAME_WITH_DATE | sed -e 's/$/'_$FILESIZE'/')
            FOR_LOG=$(echo | awk -v ONE=$NAME_WITH_DATE -v TWO=$EXISTING '{print ONE"_"TWO}')
            echo $FOR_LOG >> $LOG_LOCATION
        fi
        NEWNAME=$(echo $NEWNAME | \
            sed 's/'$FILE_FORMER'/'$FILE_FORMER''$FILE_FORMER'/')
    done

    [[ $START_FOLDER_COUNT -eq 0 ]] && return #end condition for recursy

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | \
            sed 's/'$FOLDER_FORMER'/'$FOLDER_FORMER''$FOLDER_FORMER'/')
        (( START_FOLDER_COUNT-- ))
        mkdir $FOLDERNAME
        create_one_time $FOLDERNAME $2 $START_FOLDER_COUNT $REGNAMING $REGFILENAME \
            $FOLDERNAME $FILESIZE K $9
    done    
}

function create_many_times ()
{
    cd $1
    LIST=$(ls -d */)
    if ! [[ $(echo $?) -eq 2 ]]
    then 
        for I in $LIST; do
            [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && continue
            F_COUNT=$((1+$RANDOM%100))
            NEW_FOLDER=$(echo | awk -v ONE=$1 -v TWO=$I '{print ONE"/"TWO}')
            create_many_times $NEW_FOLDER
            create_one_time $NAMING $F_COUNT 100 \
                            $NAMING $FILENAME $NEW_FOLDER $3 M $EXTENSION_NAME
        done
    fi
    
}