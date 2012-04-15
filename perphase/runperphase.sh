#!/bin/bash

for bench in art gzip equake mfc
do
		
	/home/zoo/simics-workspace/simics -stall -e '$BENCH'=$bench -x perphase.simics

done

