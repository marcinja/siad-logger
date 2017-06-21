#!/bin/bash
#Logs Disk Read (col 1) and Disk Write (col 2) bandwidth
#Units: Kilobytes / sec

# takes in argument for current time
# (since scripts should be called together) from siad=logger.sh
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
cd "$parent_path"/../logs

touch "disk-io-$1.log"

pid="$(pidof siad)"
while true; do
    iotop -k -b -d 1 -p "${pid}" | awk -v var="$pid" '/^ '"$pid"'/ { print $4,$6; fflush() }' >> "disk-io-$1.log"
    sleep 1
done
