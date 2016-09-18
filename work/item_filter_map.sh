#!/bin/bash
awk -F"\t" 'BEGIN {
	num_extra = 100;
}
{
	if(NF == 4) {
		id = $1;
		mark = $2;
		cid = $3;
		desc = $4;
		#
		print cid"\t"int(rand() * num_extra)"\t1\t"id"\t"mark"\t"cid"\t"desc;
	} else if(NF == 11) {
		cid = $1;
		term = $2;
		label = $NF;
		#
		if(label == "CID") {
			score = $9;
		} else if(label == "TF") {
			score = $10;
		}
		#
		for(i = 0; i < num_extra; i ++) {
			print cid"\t"i"\t0\t"term"\t"score"\t"label;
		}
	}
}'
