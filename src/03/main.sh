#!/bin/bash

source conditions.sh
source ../creation_func.sh

! test $E_BADARGS -eq 0 && exit $E_BADARGS
#errors of deletion to be written in /err.log
! [[ -f $(echo "/err.log") ]] && touch /err.log

if [[ $1 -eq 1 ]]; then
    read -p "write log file location (absolute path): " LOG_LOCATION; 
    ( [[ -f $1 ]] && cat $1 >/dev/null ) && \
        { echo "WRONG PATH">&2; E_BADARGS=65; exit $E_BADARGS; }  
    while read line
    do
        TO_DEL=$(echo $line | awk 'BEGIN { FS = "_" } ; {print substr($3, $NF)"/"$1"_"$2}')
        rm -f "$TO_DEL" 2>/err.log
    done < $LOG_LOCATION
fi

if [[ $1 -eq 2 ]]; then
    [[ $(echo $#) -eq 5 ]] && { D1=$2; T1=$3; D2=$4; T2=$5; }  || \
        {
            read -p "write start date (YYYY/MM/DD HH:MM): " D1 T1; 
            read -p "write start date (YYYY/MM/DD HH:MM): " D2 T2; 
            check_and_compare_2_dates $D1 $T1 $D2 $T2;
        }
        FILELIST=$(find / -newermt "$D1 $T1" ! -newermt "$D2 $T2" 2>/dev/null);
        for line in $FILELIST
        do
            rm -f "$line" 2>/err.log
        done
fi

if [[ $1 -eq 3 ]]; then
    read -p "write mask (a-z_DDMMYYYY): " MASK
    while ! [[ "$MASK" =~ $FILE_NAME_MASK ]]
    do
        echo "WRONG format. Try again"
        read -p "write mask (a-z[.a-z]_DDMMYY): " MASK
    done
    LETTERS_OF_MASK=$(echo $MASK | awk 'BEGIN { FS = "_" } ; {print $1}')
    DATE_OF_MASK=$(echo $MASK | awk 'BEGIN { FS = "_" } ; {print $2}')
    letters_first=$(echo $LETTERS_OF_MASK | awk 'BEGIN { FS = "."} ; {print $1}')
    letters_first=$(echo $letters_first | sed 's/./&'\*'/g')
    letters_second=$(echo $LETTERS_OF_MASK | awk 'BEGIN { FS = "."} ; {print $2}')
    [[ "$letters_second" -eq "" ]] && \
        { NEW_MASK=$(echo "$letters_first"_"$DATE_OF_MASK"); } || \
        { letters_second=$(echo $letters_second | sed 's/./&'\*'/g');
        NEW_MASK=$(echo "$letters_first"\."$letters_second"_"$DATE_OF_MASK"); }
    
    FILELIST=$(find / -name $NEW_MASK 2>/dev/null);
    for line in $FILELIST
    do
        rm -f "$line" 2>/err.log
    done
fi

exit $E_BADARGS;
