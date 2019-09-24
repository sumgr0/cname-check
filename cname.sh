#!/bin/bash

while read LINE; do
    echo "no_cname: $nc; host_match: $hm; cname_out: $co"
    cname=`dig $LINE CNAME +short`

    if [ -z "$cname" ]; then
        echo "$LINE" >> no_cname
<<<<<<< HEAD
<<<<<<< HEAD
        ((nc++))
=======
        nc= `wc -l < no_cname`
>>>>>>> parent of d4bb067... test-4
=======
        (($nc++))
>>>>>>> parent of 6cae205... test-5
    else
        tld_host=`echo $LINE | awk -F '[.:]' '{print $(NF-1)}'`
        tld_service=`echo $cname | awk -F '[.:]' '{print $(NF-2)}'`
        if [ "$tld_host" = "$tld_service" ]; then
            echo "$LINE" >> host_match
<<<<<<< HEAD
<<<<<<< HEAD
            ((hm++))
        else
            echo "$LINE,$cname" >> cname_out
            ((co++))
=======
            hm=`wc -l < host_match`
        else
            echo "$LINE,$cname" >> cname_out
            co=`wc -l < cname_out`
>>>>>>> parent of d4bb067... test-4
=======
            (($hm++))
        else
            echo "$LINE,$cname" >> cname_out
            (($co++))
>>>>>>> parent of 6cae205... test-5
        fi
    fi
done < $1 #file to check

echo "no_cname: $nc; host_match: $hm; cname_out: $co"