#!/bin/bash

while read LINE; do
    cname=`dig $LINE CNAME +short`

    tld_host=`echo $LINE | awk -F '[.:]' '{print $(NF-1)}'`
    tld_service=`echo $cname | awk -F '[.:]' '{print $(NF-2)}'`
    if [ "$cname" = " "]; then
        echo "$LINE" >> no_cname
    else 
        if [ "$tld_host" = "$tld_service" ]; then
            echo "$LINE" >> host_match
        else
            echo "$LINE,$cname" >> cname_out
        fi
    fi
done < $1 #file to check