#!/bin/bash
# Starts logging scripts and kills them after a given amount of seconds
# Then runs gnuplot scripts to create graph pngs

# Get current time, used to name log files consistently
# e.g. 2017-06-08_10:57:08
now=$(date +"%F-%H:%M:%S")

# Start loggers
echo "Starting up resource loggers."
bash cpu-mem-logger.sh "$now" &
bash smem-logger.sh "$now" &
bash disk-io-logger.sh "$now" &
bash network-usage-logger.sh "$now" &

sleep $1

# Turn off all loggers
pkill -f cpu-mem-logger.sh
pkill -f smem-logger.sh
pkill -f disk-io-logger.sh
pkill -f network-usage-logger.sh

# Create plots
echo "Creating plots for resource usage starting at $now ."

cd ..
# This is the logscripts directory
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

cd "$parent_path"/gnuplot-scripts

gnuplot -e "logfile='${parent_path}/logs/smem-$now.log'; result='${parent_path}/graph-results/smem-graph-$now.png'" plot-smem.script

gnuplot -e "logfile='${parent_path}/logs/network-io-$now.log'; result='${parent_path}/graph-results/network-usage-graph-$now.png'" plot-network-usage.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$now.log'; result='${parent_path}/graph-results/mem-log-graph-$now.png'" plot-mem.script

gnuplot -e "logfile='${parent_path}/logs/disk-io-$now.log'; result='${parent_path}/graph-results/disk-io-graph-$now.png'" plot-disk-io.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$now.log'; result='${parent_path}/graph-results/cpu-log-graph-$now.png'" plot-cpu.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$now.log'; result='${parent_path}/graph-results/cpu-mem-log-graph-$now.png'" plot-cpu-mem-together.script

echo "Graph results completed."
