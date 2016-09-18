#!/bin/bash
awk '{
	if(cid != $1) {
		cid = $1;
		cid_count = 0;
	}
	#
	if($2 == 0) {
		cid_count = $3;
	} else if($2 == 1) {
		#<cid> <1> <term> <cid_term_total> <term_num> <tf_score> <sigma_cid> <sigma_tf>
		term = $3;
		cid_term_total = $4;
		term_num = $5;
		tf_score = $6;
		sigma_cid = $7;
		sigma_tf = $8;
		#
		tfidf_cid = tf_score * (log(cid_count) - log(1 + sigma_cid));
		tfidf_tf = tf_score * (log(cid_count) - log(1 + sigma_tf));
		#
		print cid"\t"term"\t"cid_term_total"\t"term_num"\t"tf_score"\t"sigma_cid"\t"sigma_tf"\t"cid_count"\t"tfidf_cid"\t"tfidf_tf;
	}
}'
