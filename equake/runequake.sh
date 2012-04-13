#!/bin/bash

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=512 -e '$LINESZ'=32 -e '$ASSOC'=2 -x equake1.simics exit &> l1results/equake-16384-32-2.txt

/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=128 -e '$LINESZ'=128 -e '$ASSOC'=2 -x equake.simics exit &> l1results/equake-16384-128-2.txt

for linesize in 32 64 128
do
	linesno=$((16384/$linesize))
	
	/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=4 -x equake.simics exit &> l1results/equake-16384-${linesize}-4.txt

done


for cashesize in 32768 65536
do
	for linesize in 32 64 128
	do
		linesno=$(($cashesize/$linesize))
		
		for assoc in 4 8
	  	do
	
			/home/zoo/simics-workspace/simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=$assoc -x equake.simics exit &> l1results/equake-${cashesize}-${linesize}-${assoc}.txt

	
		done
	done
done
