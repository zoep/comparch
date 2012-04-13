#!/bin/bash

./simics -stall -e '$LINESNO'=512 -e '$LINESZ'=32 -e '$ASSOC'=2 -x
./art/art1.simics exit &> art-16384-32-2.txt

./simics -stall -e '$LINESNO'=128 -e '$LINESZ'=128 -e '$ASSOC'=2 -x
./art/art.simics exit &> art-16384-128-2.txt

./simics -stall -e '$LINESNO'=512 -e '$LINESZ'=32 -e '$ASSOC'=4 -x
./art/art.simics exit &> art-16384-32-4.txt

./simics -stall -e '$LINESNO'=128 -e '$LINESZ'=128 -e '$ASSOC'=4 -x
./art/art.simics exit &> art-16384-128-4.txt

for cashesize in 32768 65536
do
	for linesize in 32 128
	do
		linesno=$(($cashesize)/($linesize))
		
		for assoc in 4 8
	  	do
	
			./simics -stall -e '$LINESNO'=$linesno -e '$LINESZ'=$linesize -e '$ASSOC'=$assoc -x
			./art/art.simics exit &> art${cashesize}-${linesize}-${assoc}.txt

	
		done
	done
done
