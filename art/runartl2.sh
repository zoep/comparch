#!/bin/bash

for cashesize in 262144 524288
do
	linesno=$(($cashesize/128))
		
	~/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=128 -e '$ASSOC'=4 -x art.simics  &> l2results/art-${cashesize}-128-4.txt

done


for cashesize in 524288 1048576 2097152
do
	for linesize in 64 128 256
	do
		linesno=$(($cashesize/$linesize))
		
		~/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=8 -x art.simics  &> l2results/art-${cashesize}-${linesize}-8.txt

	done
done


for cashesize in 1048576 2097152
do
	linesno=$(($cashesize/128))
		
	~/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=128 -e '$ASSOC'=16 -x art.simics  &> l2results/art-${cashesize}-128-16.txt

done

