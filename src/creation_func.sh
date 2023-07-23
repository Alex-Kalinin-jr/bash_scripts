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



function create_one_time_var_2 ()
{
    cd $1

    SCRIPT_DATE=$(date +"%d%m%y")
    NAME_WITH_DATE=$(echo $3 | sed 's/$/'_$SCRIPT_DATE'/')
    echo $NAME_WITH_DATE
    FILECOUNT=$(echo $(( 1+$RANDOM%100 )) )
    FILESIZE=$4

    START_FOLDER_COUNT=100

    REGNAMING=$2
    REGFILENAME=$5
    FILE_FORMER=${REGFILENAME:0:1}
    FOLDER_FORMER=${REGNAMING:0:1}

    FILECOUNT=$( echo $(( 1+$RANDOM%100 )) )

    for (( y=1; y<=$FILECOUNT; y++ )); do
        FREE_SPACE=$(df -B G / | awk '{print $4}' | sed -e 's/G//')
        FREE_SPACE=$(echo $FREE_SPACE | awk '{print $2}' | sed -n '$p')
        [[ $FREE_SPACE -lt 1 ]] && return #end condition for loop
        truncate -s $FILESIZE"M" $NAME_WITH_DATE
        NAME_WITH_DATE=$(echo $NAME_WITH_DATE | \
            sed 's/'$FILE_FORMER'/'$FILE_FORMER''$FILE_FORMER'/')
    done



    # [[ $4 -eq 0 ]] && return #end condition for recursy

    # for (( y=1; y<=$START_FOLDER_COUNT; y++)); do

    # done    
}