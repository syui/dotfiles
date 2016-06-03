#!/bin/sh
# Show network statistics for all active interfaces found.

#run_segment() {
#    rx=`ifstat -j | jq '.kernel[].rx_bytes' | head -n 1`
#    tx=`ifstat -j | jq '.kernel[].tx_bytes' | head -n 1`
#    rx=`expr $rx / 1000000`
#    tx=`expr $tx / 1000000`
#    ifs=$(echo "⇊ 0.${rx} ⇈ 0.${tx}")
#    echo $ifs
#}

run_segment() {
    rx=`ifstat -j | jq '.kernel[].rx_packets' | head -n 2`
    tx=`ifstat -j | jq '.kernel[].tx_packets' | head -n 2`
    rx=`echo $rx | cut -b 4-`
    tx=`echo $tx | cut -b 4-`
    ifs=$(echo "⇊ 0.${rx} ⇈ 0.${tx}")
    echo $ifs
}
