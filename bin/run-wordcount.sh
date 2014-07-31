#!/bin/bash
set -e

export HADOOP_CONF_DIR=~/.whirr/hadoop-yarn

# Generate sample input 10 x 1MB per node
if [ "$1" != "no-prepare" ]; then 
	hadoop fs -rm -r -f input
	hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar randomtextwriter \
 		-D mapreduce.randomtextwriter.bytespermap=1048576\
 		-D mapreduce.randomtextwriter.mapsperhost=10 \
 		input 
fi

# Run word count
hadoop fs -rm -r -f output
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount \
 input output


