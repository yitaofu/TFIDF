#!/bin/bash
awk '{
	cid = $1;
	label = $2;
	term = $3;
	term_num = $4;
	#
	if(label == 0) {
		print "*\t"cid"\t"term_num;
	}
}'
