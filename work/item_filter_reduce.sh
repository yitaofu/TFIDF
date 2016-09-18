#!/bin/bash
#
awk '{
	tmp_key = $1"\t"$2;
	if(key != tmp_key) {
		key = tmp_key;
		#
		cid = $1;
		delete dict_tfidf_cid;
		delete dict_tfidf_tf;
	}
	#
	if($3 == "0") {
		term = $4;
		score = $5;
		label = $6;
		#
		if(label == "CID") {
			dict_tfidf_cid[cid"\t"term] = score;
		} else if(label == "TF") {
			dict_tfidf_tf[cid"\t"term] = score;
		}
	} else if($3 == "1") {
		id = $4;
		mark = $5;
		desc = "";
		#
		for(i = 7; i <= NF; i ++) {
			term = toupper($i);
			if(dict_tfidf_cid[cid"\t"term] != "" || dict_tfidf_tf[cid"\t"term] != "") {
				if(desc == "") {
					desc = term;
				} else {
					desc = desc" "term;
				}
			}
		}
		#
		if(desc != "") {
			print id"\t"mark"\t"cid"\t"desc;
		}
	}
}'
