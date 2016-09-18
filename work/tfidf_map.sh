#!/bin/bash
awk '{
	if(NF == 3) {
		#cid
		#<cid> <cid_count> <term_num>
		cid = $1;
		cid_count = $2;
		term_num = $3;
		#
		print cid"\t0\t"cid_count"\t"term_num;
	} else {
		#idf
		#<term> <cid> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf>
		term = $1;
		cid = $2;
		cid_term_total = $3;
		term_num = $4;
		tf_score = $5;
		sigma_cid = $6;
		sigma_tf = $7;
		#
		print cid"\t1\t"term"\t"cid_term_total"\t"term_num"\t"tf_score"\t"sigma_cid"\t"sigma_tf;
	}
}'
