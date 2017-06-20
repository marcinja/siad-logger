# Siad Loggers

## What is it?
This is a set of scripts that logs resource usage of the Sia daemon. Specifically, it contains individual scripts for logging disk I/O, network I/O, CPU usage, and memory usage. There are also several scripts that run those loggers together, and give their outputs names corresponding to the time the script was started.  

## Requires:
`nethogs`, `iotop`, `top`, `smem`, `gnuplot`, `siad`, `siac`

## Usage:
It is recommended (for now), that you run `siad-block-download-logger.sh`, and then manually check when the logs have been written to disk. Then run `siad-grapher.sh` to graph the logs.

As of right now, it takes some time for the logs to be written to, especially the CPU and disk I/O logs. Once that is fixed, you should be able to just run `siad-logger.sh` for everything to be done at once.


The logging scripts must be run as root because some of the utilities used require it. For example you can do `sudo -E env "PATH=$PATH" ./siad-block-download-logger.sh 10000`
