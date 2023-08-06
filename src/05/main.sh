#!/bin/bash

source ../regexps.sh

[[ $# -eq 1 ]] && [[ $1 =~ $MATCH_NUM ]] &&\
[[ $1 -le 4 ]] || { echo "WRONG"; E_BADARGS=65; exit ${E_BADARGS}; }

[[ $1 -eq 1 ]] && { awk -FS=" - " '{print $0}' \
    ../04/sorted_nginx.log | sort -k2 1>>sorted_by_response.log; }

[[ $1 -eq 2 ]] && { awk '!seen[$1]++' \
    ../04/sorted_nginx.log 1>nginx_unique_ips.log; }

[[ $1 -eq 3 ]] && awk '/- [45][0-9][0-9] -/ {print $0}' .\
    ./04/sorted_nginx.log 1>nginx_error.log;

[[ $1 -eq 4 ]] && awk '(/- [45][0-9][0-9] -/) && (!seen[$1]++) {print $0}' \
    ../04/sorted_nginx.log 1>nginx_error_unique_ips.log;

