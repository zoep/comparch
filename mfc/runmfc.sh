#!/bin/bash

~/simics-workspace/simics -stall -e '$LINESNO'=256 -e '$LINESZ'=64 -e '$ASSOC'=2 -x mfc1.simics  &> l1results/mfc-16384-64-2.txt

for linesize in 32 64 128
do
	linesno=$((16384/$linesize))
	
	~/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=4 -x mfc.simics  &> l1results/mfc-16384-${linesize}-4.txt

done


for cashesize in 32768 65536
do
	for linesize in 32 64 128
	do
		linesno=$(($cashesize/$linesize))
		
		for assoc in 4 8
	  	do
	
			~/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=$assoc -x mfc.simics  &> l1results/mfc-${cashesize}-${linesize}-${assoc}.txt

	
		done
	done
done
