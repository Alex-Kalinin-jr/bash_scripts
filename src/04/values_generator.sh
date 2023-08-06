#!/bin/bash

source arrays.sh

ran_ip() 
{
new_ip=$(printf "%d.%d.%d.%d\n" \
    "$((RANDOM % 256))" "$((RANDOM % 256))" \
    "$((RANDOM % 256))" "$((RANDOM % 256))") 
echo ${new_ip}
}

#top border is $1
random_number()
{
    for_num=$((${1}+1))
    num=$(($RANDOM%$for_num))
    [[ $num -le 9 ]] && { num=$(echo "0$num"); }
    echo ${num}
}

ran_time()
{
    a=$(date -d "24 hours ago" +%Y-%m-%d)
    b=$(random_number 23)
    c=$(random_number 59)
    d=$(random_number 59)
    time1=$(date --date="$a $b:$c:$d" "+%d/%m/%Y:%T %z" 2> /dev/null)
    echo ${time1}
}

random_array_record()
{
    arr=("$@")
    count=${#arr[@]}
    INDEX=$(($RANDOM%$count))
    RAN_CODE=$(echo ${arr[${INDEX}]})
    echo ${RAN_CODE}
}

ran_line()
{
    SOURCE_FILE=$1
    LINES_COUNT=$(wc -l ${SOURCE_FILE} | awk '{print $1}')
    INDEX=$(($RANDOM%$LINES_COUNT+1)) 
    new_line=$(sed -n "${INDEX}"p ${SOURCE_FILE})
    echo ${new_line}
}


