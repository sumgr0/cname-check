#!/bin/bash

nc=0
hm=0
co=0

wc -l $1
while read LINE; do
    echo -ne "no_cname: $nc; host_match: $hm; cname_out: $co \r"
    cname=`dig $LINE CNAME +short`

    if [ -z "$cname" ]; then
        echo "$LINE" >> no_cname
        ((nc++))
    else
        tld_host=`echo $LINE | awk -F '[.:]' '{print $(NF-1)}'`
        tld_service=`echo $cname | awk -F '[.:]' '{print $(NF-2)}'`
        if [ "$tld_host" = "$tld_service" ]; then
            echo "$LINE" >> host_match
            ((hm++))
        else
            echo "$LINE ==> $cname" >> cname_out
            ((co++))
        fi
    fi
done < $1 #file to check
echo "no_cname: $nc; host_match: $hm; cname_out: $co"
