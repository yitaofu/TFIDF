#!/bin/bash
export LC_ALL="zh_CN.UTF-8";
#
awk '{
	cid = $3;
	#
	for(i = 4; i <= NF; i ++) {
		if(length($i) < 2) {
			continue;
		}
		#
		uniq_term[toupper($i)] += 1;
	}
	#
	num = 0;
	#
	for(term in uniq_term) {
		print cid"\t1\t"term"\t1";
		num ++;
	}
	#
	if(cid != "" && num > 0) {
		print cid"\t0\t*\t"num;
	}
	############
	delete uniq_term;
}' | awk -F"\t" 'BEGIN {
	num = 0;
}
{
	stat[$1"\t"$2"\t"$3] += $4;
	num += 1;
	#
	if(num >= 1000000) {
		for(key in stat) print key"\t"stat[key];
		#
		delete stat;
		num = 0;
	}	
}
END {
	if(num > 0) {
		for(key in stat) print key"\t"stat[key];
		#
		delete stat;
		num = 0;
	}
}'
