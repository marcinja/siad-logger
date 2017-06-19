#!/bin/bash
##Logs CPU, Memory use percentage into 2 columns


# takes in argument for current time
# (since scripts should be called together) from siad=logger.sh
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
cd "$parent_path"/../logs

touch "cpu-mem-$1.log"

pid="$(pidof siad)"
while true; do
    top -b -d 1 -p "${pid}" | awk -v var="$pid" '/^ '"$pid"'/ { print $9,$10 }' >> "cpu-mem-$1.log"
done
