#/bin/bash

source ../regexps.sh

E_BADARG=0
echo $LOG_FILE
! [[ -f $1 ]] && { echo "WRONG"; E_BADARG=33; }

! [[ $E_BADARG -eq 0 ]] && { exit $E_BADARG; }

cp goaccess.conf /etc/goaccess/goaccess.conf
goaccess $1 -o report.html
xdg-open report.html