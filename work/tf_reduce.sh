#!/bin/bash
awk '{
	if(cid != $1) {
		cid = $1;
		cid_term_total = 0;
	}
	#
	if($2 == 0) {
		cid_term_total = $4;
	} else if($2 == 1) {
		term = $3;
		term_num = $4;
		print cid"\t"term"\t"cid_term_total"\t"term_num"\t"(1.0 * term_num / cid_term_total);
	}
}'
