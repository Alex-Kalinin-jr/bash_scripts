#!/bin/bash

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
 

ran_time()
{
    a=$(start_ymd)
    b=$(ran_hour)
    c=$(ran_min)
    d=$(ran_sec)q
    time1=$(date --date="$a $b:$c:$d" "+%d/%m/%Y:%T %z" 2> /dev/null)
    echo ${time1}
}
 