#!/bin/bash

source arrays.sh

ran_ip()
{
new_ip=$(printf "%d.%d.%d.%d\n" \
"$((RANDOM % 256))" "$((RANDOM % 256))" \
"$((RANDOM % 256))" "$((RANDOM % 256))") 
echo ${new_ip}
}

start_ymd()
{
ymd=`date -d "24 hours ago" +%Y-%m-%d`
echo ${ymd}
}
 
#Generate the specified range of hours
ran_hour()
{
    x=$(echo {00..23})
    array=($x)
    num=$(($RANDOM%24))
    hour=$(echo ${array[${num}]})
    echo ${hour}
}
ran_min()
{
    x=$(echo {00..59})
    array=($x)
    num=$(($RANDOM%60))
    min=$(echo ${array[${num}]})
    echo ${min}
}

ran_sec()
{
    x=$(echo {00..59})
    array=($x)
    num=$(($RANDOM%60))
    sec=$(echo ${array[${num}]})
    echo ${sec}
}
 
#needed value is $time1
ran_time()
{
    a=$(start_ymd)
    b=$(ran_hour)
    c=$(ran_min)
    d=$(ran_sec)q
    time1=$(date --date="$a $b:$c:$d" "+%d/%m/%Y:%T %z" 2> /dev/null)
    echo ${time1}
}

ran_code()
{
    INDEX=$(($RANDOM%10))
    RAN_CODE=$(echo ${CODES[${INDEX}]})
    echo ${RAN_CODE}
}

ran_proto()
{
    INDEX=$(($RANDOM%3))
    RAN_PROTO=$(echo ${VERSIONS[${INDEX}]})
    echo ${RAN_PROTO}
}

ran_method()
{
    M_INDEX=$(($RANDOM%5))
    RAN_INDEX=$(echo ${METHODS[${M_INDEX}]})
    echo ${RAN_INDEX}
}

ran_line()
{
    SOURCE_FILE=$1
    LINES_COUNT=$(wc -l ${SOURCE_FILE} | awk '{print $1}')
    INDEX=$(($RANDOM%$LINES_COUNT+1)) 
    new_line=$(sed -n "${INDEX}"p ${SOURCE_FILE})
    echo ${new_line}
}


