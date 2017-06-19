#!/bin/bash
# Logs KB in/out for a process (col 1 = sent, col 2 = received)

# takes in argument for current time
# (since scripts should be called together) from siad=logger.sh
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
cd "$parent_path"/../logs

touch "network-io-$1.log"

while true; do
    nethogs -d 1 -v 1 -t | awk '/siad/' >> "network-io-$1.log"
done
