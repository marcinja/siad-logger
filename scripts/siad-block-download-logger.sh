#!/bin/bash
# Starts logging scripts and kills them after siac reports that at least the
# given number of blocks have been downloaded.

# Get current time, used to name log files consistently
# e.g. 2017-06-08_10:57:08
now=$(date +"%F-%H:%M:%S")

# Start loggers
echo "Starting up resource loggers."
bash cpu-mem-logger.sh "$now" &
bash smem-logger.sh "$now" &
bash disk-io-logger.sh "$now" &
bash network-usage-logger.sh "$now" &

# Query siac for blockheight. Shutdown once at $1 blocks
while true; do
    blockheight=$(siac | awk '/Height/ { print $2 }')
    if [ "$blockheight" -ge "$1" ]; then
        break
    fi
    sleep 1
done

# Turn off all loggers
pkill -f cpu-mem-logger.sh
pkill -f smem-logger.sh
pkill -f disk-io-logger.sh
pkill -f network-usage-logger.sh

echo "Loggers shut down. Recored logs starting at: $now"
