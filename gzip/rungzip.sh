#!/bin/bash

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=512 -e '$LINESZ'=32 -e '$ASSOC'=2 -x gzip1.simics exit &> gzip-16384-32-2.txt

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=128 -e '$LINESZ'=128 -e '$ASSOC'=2 -x gzip.simics exit &> gzip-16384-128-2.txt

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=512 -e '$LINESZ'=32 -e '$ASSOC'=4 -x gzip.simics exit &> gzip-16384-32-4.txt

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=128 -e '$LINESZ'=128 -e '$ASSOC'=4 -x gzip.simics exit &> gzip-16384-128-4.txt

for cashesize in 32768 65536
do
	for linesize in 32 128
	do
		linesno=$(($cashesize/$linesize))
		
		for assoc in 4 8
	  	do
	
			/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=$assoc -x gzip.simics exit &> gzip${cashesize}-${linesize}-${assoc}.txt

	
		done
	done
done