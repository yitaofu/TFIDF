#!/bin/bash
awk '{
	if(term != $1) {
		if(term != "") {
			for(d in stat) {
				print d"\t"sigma_cid"\t"sigma_tf;
			}
			#
			delete stat;
		}
		#
		term = $1;
		sigma_cid = 0;
		sigma_tf = 0.0;
	}
	#
	tf = $NF;
	sigma_cid += 1;
	sigma_tf += tf;
	#
	stat[$0] = 1;
}
END {
	if(term != "") {
		for(d in stat) {
			print d"\t"sigma_cid"\t"sigma_tf;
		}
		#
		delete stat;
	}
}'
