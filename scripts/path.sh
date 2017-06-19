#!/bin/bash

now=$(date +"%F-%H:%M:%S")

cd ..
# This is the logscripts directory
parent_path="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

cd "$parent_path"/gnuplot-scripts

#
echo $(pwd)
gnuplot -e "logfile='${parent_path}/logs/smem-$now.log'; result='${parent_path}/graph-results/smem-graph-$now.png'" plot-smem.script
