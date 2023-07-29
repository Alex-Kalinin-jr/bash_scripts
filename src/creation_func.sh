function create_one_time ()
{
    cd $3
    NEWNAME=$INITIAL_NAME
    FOLDERNAME=$(echo $1)
    for (( y=1; y<=$FILECOUNT; y++ )); do
        FREE_SPACE=$(df -B G / | awk '{print $4}' | sed -e 's/G//')
        FREE_SPACE=$(echo $FREE_SPACE | awk '{print $2}' | sed -n '$p')
        [[ $FREE_SPACE -lt 1 ]] && return #end condition for loop

        truncate -s $FILESIZE"$2" $NEWNAME 2>/dev/null
        CHECK_TRUNC=$(echo $?)

        if [[ $CHECK_TRUNC -eq 0 ]]; then
            NAME_WITH_DATE=$(echo $NEWNAME | sed 's/$/'_$SCRIPT_DATE'/')
            EXISTING=$(echo $PWD)
            FOR_LOG=$(echo $NAME_WITH_DATE | sed -e 's/$/'_$FILESIZE'/')
            FOR_LOG=$(echo | awk -v ONE=$NAME_WITH_DATE -v TWO=$EXISTING '{print ONE"_"TWO}')
            echo $FOR_LOG >> $LOG_LOCATION
            NEWNAME=$(echo $NEWNAME | \
                sed 's/\(.*\)'$FILE_FORMER'/\1'$FILE_FORMER''$FILE_FORMER'/')
        fi
    done

    [[ $START_FOLDER_COUNT -eq 0 ]] && return #end condition for recursy

    for (( y=1; y<=$START_FOLDER_COUNT; y++)); do
        FOLDERNAME=$(echo $FOLDERNAME | \
            sed 's/\(.*\)'$FOLDER_FORMER'/\1'$FOLDER_FORMER''$FOLDER_FORMER'/')
        (( START_FOLDER_COUNT-- ))
        mkdir "$FOLDERNAME"
        create_one_time "$FOLDERNAME" "$2" "$FOLDERNAME"
    done    
}

function create_many_times ()
{
    cd "$1"
    echo "now we are in $PWD"
    LIST=$(ls -d */) 2> /dev/null
    START_FOLDER_COUNT=100
    mkdir "$REGNAMING"
    FILECOUNT=$((1+$RANDOM%100))
    create_one_time "$REGNAMING" "M" "$REGNAMING"
    if ! [[ $(echo $?) -eq 2 ]]
    then 
        for I in $LIST; do
            [[ "$I" =~ $MATCH_RESTRICTED_FOLDERS ]] && continue
            [[ "$I" =~ $REGNAMING ]] && continue
            NEW_FOLDER=$(echo | awk -v ONE=$1 -v TWO=$I '{print ONE"/"TWO}')
            create_many_times $NEW_FOLDER
        done
    fi
    
}
# bash main.sh ab cd.ef 30
# git commit -a -m 'recursy of 1 func to be repaired for 2nd script.'