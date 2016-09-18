#!/bin/bash
awk '{
	if(label != $1) {
		if(label != "") {
			for(cid in stat) {
				print cid"\t"cid_count"\t"stat[cid];
			}
			#
			delete stat;
		}
		#
		label = $1;
		cid_count = 0;
	}
	#
	cid = $2;
	term_num = $3;
	#
	cid_count += 1;
	stat[cid] = term_num;
}
END {
	if(label != "") {
		for(cid in stat) {
			print cid"\t"cid_count"\t"stat[cid];
		}
		#
		delete stat;
	}
}'
