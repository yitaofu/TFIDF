#!/bin/bash
awk '{
	cid = $1;
	term = $2;
	cid_term_total = $3;
	term_num = $4;
	df = $5;
	#
	print term"\t"cid"\t"cid_term_total"\t"term_num"\t"df;
}'
