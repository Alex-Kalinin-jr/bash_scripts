#! /bin/bash

source arrays.sh
source ../regexps.sh
source dt_generator.sh

# while [[  ]]
NEW_IP=$(printf "%d.%d.%d.%d\n" \
    "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))")
 #192.168.0.1 - - [28/Mar/2023:05:31:22 +0000] "GET / HTTP/1.1" 200 12345  #####here 12345 is answ size in bytes
 #+"-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) 
 #+Chrome/109.0.5414.119 Safari/537.36"

ran_time
