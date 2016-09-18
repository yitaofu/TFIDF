#!/bin/bash
CUR_PATH=`dirname $0`;
WORK_PATH="$CUR_PATH/../work";
DATA_PATH=`pwd`;
#
if [ $# -lt 2 ]
then echo "demo: $0 <name> <dat.src>"; exit 0;
fi
#
TEST_NAME=$1;
TEST_DATA=$2;
#
mkdir -p $DATA_PATH/$TEST_NAME;
# #################################################
export LC_ALL=C;
#cid_term
cat $TEST_DATA | sh $WORK_PATH/cid_term_map.sh | sort | sh $WORK_PATH/cid_term_reduce.sh >$DATA_PATH/$TEST_NAME/cid_term.dat;

#tf
cat $DATA_PATH/$TEST_NAME/cid_term.dat | sh $WORK_PATH/tf_map.sh | sort | sh $WORK_PATH/tf_reduce.sh >$DATA_PATH/$TEST_NAME/tf.dat;

#idf
cat $DATA_PATH/$TEST_NAME/tf.dat | sh $WORK_PATH/idf_map.sh | sort | sh $WORK_PATH/idf_reduce.sh >$DATA_PATH/$TEST_NAME/idf.dat;

#cid
cat $DATA_PATH/$TEST_NAME/cid_term.dat | sh $WORK_PATH/cid_map.sh | sort | sh $WORK_PATH/cid_reduce.sh >$DATA_PATH/$TEST_NAME/cid.dat;

#tfidf
cat $DATA_PATH/$TEST_NAME/cid.dat $DATA_PATH/$TEST_NAME/idf.dat | sh $WORK_PATH/tfidf_map.sh | sort | sh $WORK_PATH/tfidf_reduce.sh >$DATA_PATH/$TEST_NAME/tfidf.dat;

#topn
cat $DATA_PATH/$TEST_NAME/tfidf.dat | sh $WORK_PATH/topn_map.sh | sort | sh $WORK_PATH/topn_reduce.sh 10 0.01 >$DATA_PATH/$TEST_NAME/topn.dat;

#item_filter
cat $DATA_PATH/$TEST_NAME/topn.dat $TEST_DATA | sh $WORK_PATH/item_filter_map.sh | sort | sh $WORK_PATH/item_filter_reduce.sh >$DATA_PATH/$TEST_NAME/item_filter.dat;

