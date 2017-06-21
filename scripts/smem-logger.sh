#!/bin/bash
## Logs memory usage of the siad process.: USS, PSS, RSS (in KB)

# Proportional Set Size (PSS) : Representation of the amount of memory used by libraries and applications in a virtual memory system.

# Unique Set Size (USS) : Unshared memory is reported as the USS (Unique Set Size).

# Resident Set Size (RSS) : The standard measure of physical memory (it typically shared among multiple applications) usage known as resident set size (RSS) will significantly overestimate memory usage.

# takes in argument for current time
# (since scripts should be called together) from siad=logger.sh
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
cd "$parent_path"/../logs

touch "smem-$1.log"

pid="$(pidof siad)"
while true; do
    smem | awk '/^ '"$pid"'/ { print $5,$6,$7 >> "smem-'"$1"'.log" }'
    sleep 1
done
