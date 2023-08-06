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
    a=$(date -d "24 hours ago" +%s)
    b=$(echo "$((RANDOM % 86400))")
    a=$(($a+$b))
    time1=$(date -u -d @${a} "+%d/%m/%Y:%T %z" 2> /dev/null)
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


