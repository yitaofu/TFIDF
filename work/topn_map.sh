#!/bin/bash
awk 'BEGIN {
	max = 1.0E+8;
	alpha = 1.0E+4;
}
{
	cid = $1;
	term = $2;
	cid_term_total = $3;
	term_num = $4;
	tf_score = $5;
	sigma_cid = $6;
	sigma_tf = $7;
	cid_count = $8;
	tfidf_cid = $9;
	tfidf_tf = $10;
	#
	if(tfidf_cid > alpha || tfidf_tf > alpha) {
		print $0 > "/dev/stderr";
		exit 1;
	}
	#
	print cid"\tCID\t"int(max * (alpha - tfidf_cid))"\t"tfidf_cid"\t"cid"\t"term"\t"cid_term_total"\t"term_num"\t"tf_score"\t"sigma_cid"\t"sigma_tf"\t"cid_count"\t"tfidf_cid"\t"tfidf_tf;
	print cid"\tTF\t"int(max * (alpha - tfidf_tf))"\t"tfidf_tf"\t"cid"\t"term"\t"cid_term_total"\t"term_num"\t"tf_score"\t"sigma_cid"\t"sigma_tf"\t"cid_count"\t"tfidf_cid"\t"tfidf_tf;
}'
