#/bin/bash

source ../regexps.sh

E_BADARG=0
echo $LOG_FILE
# ! [[ "$1" =~ "$LOG_FILE" ]] && { echo "WRONG"; E_BADARG=34; }
! [[ -f $1 ]] && { echo "WRONG"; E_BADARG=33; }

! [[ $E_BADARG -eq 0 ]] && { exit $E_BADARG; }

cp goaccess.conf /etc/goaccess/goaccess.conf
goaccess $1 -o report.html
# goacess ../05/nginx_unique_ips.log -o report.html
xdg-open report.html