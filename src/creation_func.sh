function create_one_time ()
{
    cd $3
    NEWNAME=$INITIAL_NAME
    FOLDERNAME=$(echo $1)
    for (( y=1; y<=$FILECOUNT; y++ )); do
        FREE_SPACE=$(df -B G / | awk '{print $4}' | sed -e 's/G//')
        FREE_SPACE=$(echo $FREE_SPACE | awk '{print $2}' | sed -n '$p')
        [[ $FREE_SPACE -lt 1 ]] && return #end condition for loop

        NAME_WITH_DATE=$(echo $NEWNAME | sed 's/$/'_$SCRIPT_DATE'/')
        truncate -s $FILESIZE"$2" $NAME_WITH_DATE 2>/dev/null
        CHECK_TRUNC=$(echo $?)

        if [[ $CHECK_TRUNC -eq 0 ]]; then
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
    LIST=$(ls -d */ 2> /dev/null) 
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

#at first func checks dates for correctness
check_and_compare_2_dates ()
{
    ( START=$(date --date="$1 $2" "+%d-%m-%Y %H:%M start" 2> /dev/null) && \
    END=$(date --date="$3 $4" "+%d-%m-%Y %H:%M end" 2> /dev/null) ) || \
    { echo "WRONG DATE TIME FORMAT: should be YYYY/MM/DD and HH:MM"; E_BADARGS=65; }
    #then compares date interval for correctness
    if ! [[ $E_BADARGS -eq 65 ]]; then
    START=$(date --date="$1 $2" +%s) 
    END=$(date --date="$3 $4" +%s) 
        if [[ $START -ge $END ]]; then
            echo "WRONG: LAST DATE IS EARLIER"; E_BADARGS=1; return 1;
        else
            return 0;
        fi
    fi
}
