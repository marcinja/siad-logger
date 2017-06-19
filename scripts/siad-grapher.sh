#!/bin/bash
# Starts up gnuplots scripts that graph the log files started at the given time

# Create plots
echo "Creating plots for resource usage starting at $1 ."

cd ..
# This is the logscripts directory
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

cd "$parent_path"/gnuplot-scripts

gnuplot -e "logfile='${parent_path}/logs/smem-$1.log'; result='${parent_path}/graph-results/smem-graph-$1.png'" plot-smem.script

gnuplot -e "logfile='${parent_path}/logs/network-io-$1.log'; result='${parent_path}/graph-results/network-usage-graph-$1.png'" plot-network-usage.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$1.log'; result='${parent_path}/graph-results/mem-log-graph-$1.png'" plot-mem.script

gnuplot -e "logfile='${parent_path}/logs/disk-io-$1.log'; result='${parent_path}/graph-results/disk-io-graph-$1.png'" plot-disk-io.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$1.log'; result='${parent_path}/graph-results/cpu-log-graph-$1.png'" plot-cpu.script

gnuplot -e "logfile='${parent_path}/logs/cpu-mem-$1.log'; result='${parent_path}/graph-results/cpu-mem-log-graph-$now.png'" plot-cpu-mem-together.script

echo "Graph results completed."
