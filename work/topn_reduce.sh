#!/bin/bash
if [ $# -lt 2 ]
then echo "demo: $0 <topn> <rho>"; exit 1;
fi
#
TOPN=$1;
RHO=$2;
#
awk -v topn=$TOPN -v rho=$RHO '{
	if(key != $1"\t"$2) {
		key = $1"\t"$2;
		num = 0;
	}
	#
	label = $2;
	score = $4;
	if(num > topn || score < rho) {
		next;
	}
	#
	value = $5;
	for(i = 6; i <= NF; i ++) {
		value = value"\t"$i;
	}
	value = value"\t"label;
	#
	print value;
	num += 1;
}'
