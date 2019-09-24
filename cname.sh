#!/bin/bash

while read LINE; do
    cname=`dig $LINE CNAME +short`

    if [ -z "$cname" ]; then
        echo "$LINE" >> no_cname
    else
        tld_host=`echo $LINE | awk -F '[.:]' '{print $(NF-1)}'`
        tld_service=`echo $cname | awk -F '[.:]' '{print $(NF-2)}'`
        if [ "$tld_host" = "$tld_service" ]; then
            echo "$LINE" >> host_match
        else
            echo "$LINE,$cname" >> cname_out
        fi
    fi
tail -f no_cname | while read -r line ; do ((a++)) ; echo -ne "no_cname: \r$a" ; done
tail -f host_match | while read -r line ; do ((a++)) ; echo -ne "host_match: \r$b" ; done
tail -f cname_out | while read -r line ; do ((a++)) ; echo -ne "cname_out: \r$a" ; done
done < $1 #file to check