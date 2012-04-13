#!/bin/bash

for cashesize in 262144 524288
do
	linesno=$(($cashesize/128))
		
	/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=4 -x gzip.simics exit &> l2results/gzip-${cashesize}-128-4.txt

done


for cashesize in 524288 1048567 2097152
do
	for linesize in 64 128 256
	do
		linesno=$(($cashesize/$linesize))
		
		/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=8 -x gzip.simics exit &> l2results/gzip-${cashesize}-${linesize}-8.txt

	done
done


for cashesize in 1048567 2097152
do
	linesno=$(($cashesize/128))
		
	/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=16 -x gzip.simics exit &> l2results/gzip-${cashesize}-128-8.txt

done

