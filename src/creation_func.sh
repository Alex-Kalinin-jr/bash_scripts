function create_one_time ()
{
    cd $6
    SCRIPT_DATE=$(date +"%d%m%y")
    NAME_WITH_DATE=$(echo $5 | sed 's/$/'_$SCRIPT_DATE'/')
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

        truncate -s $FILESIZE"K" $NAME_WITH_DATE
        EXISTING=$(echo $PWD)
        FOR_LOG=$(echo $NAME_WITH_DATE | sed -e 's/$/'_$FILESIZE'/')
        FOR_LOG=$(echo | awk -v ONE=$NAME_WITH_DATE -v TWO=$EXISTING '{print ONE"_"TWO}')
        echo $FOR_LOG >> $LOG_LOCATION

        NAME_WITH_DATE=$(echo $NAME_WITH_DATE | \
            sed 's/'$FILE_FORMER'/'$FILE_FORMER''$FILE_FORMER'/')
    done

    [[ $START_FOLDER_COUNT -eq 0 ]] && return #end condition for recursy

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | \
            sed 's/'$FOLDER_FORMER'/'$FOLDER_FORMER''$FOLDER_FORMER'/')
        (( START_FOLDER_COUNT-- ))
        mkdir $FOLDERNAME
        create_one_time $FOLDERNAME $2 $START_FOLDER_COUNT $REGNAMING $REGFILENAME \
            $FOLDERNAME $FILESIZE 
    done    
}

function create_many_times ()
{
    cd $1
    LIST=$(ls -d */)
    if ! [[ $(echo $?) -eq 2 ]]
    then 
        for I in $LIST; do
            CUR_FOLDER=$(echo $PWD)
            [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && continue
            F_COUNT=$((1+$RANDOM%100))
            NEW_FOLDER=$(echo | awk -v ONE=$CUR_FOLDER -v TWO=$I '{print ONE"/"TWO}')
            create_many_times $NEW_FOLDER
            create_one_time $NAMING $F_COUNT 2 $NAMING $FILENAME $I $3
            cd $CUR_FOLDER
        done
    fi
    
}