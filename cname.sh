#!/bin/bash

while read LINE; do
    cname=`dig $LINE CNAME +short`

    if [ -z "$cname" ]; then
        echo "$LINE" >> no_cname
        nc= `wc -l < no_cname`
    else
        tld_host=`echo $LINE | awk -F '[.:]' '{print $(NF-1)}'`
        tld_service=`echo $cname | awk -F '[.:]' '{print $(NF-2)}'`
        if [ "$tld_host" = "$tld_service" ]; then
            echo "$LINE" >> host_match
            hm=`wc -l < host_match`
        else
            echo "$LINE,$cname" >> cname_out
            co=`wc -l < cname_out`
        fi
    fi
    echo "no_cname: $nc; host_match: $hm; cname_out: $co"
done < $1 #file to check