#!/bin/bash

COUNT=$(dogecoind getblockcount)
PREVTIME=0

for (( i=0; i<=$COUNT; i++ ))
do
    HASH=$(dogecoind getblockhash $i)
    TIME=$(dogecoind getblock $HASH|jq ".time")

    if (( "$i" > 0 )); then
        echo "$(expr $i - 1)-$i     $(expr $TIME - $PREVTIME)"

        #progress display
        if (( $(($i % $(($COUNT / 100)))) == 0)); then
            echo "$i*100/$COUNT"|bc|tr '\n' '%' 1>&2
            echo "" 1>&2
        fi
    fi

    PREVTIME=$TIME
done

