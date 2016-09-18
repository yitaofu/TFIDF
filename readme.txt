TF/IDF
文档的定义：
以叶子类目下的商品描述集合作为文档。
词的定义：
词的概念为term，商品对，即描述中包含某一term的商品作为一个词；其隐含的意义就是对单个商品描述中的term进行去重。

任务脚本：
cid_term_map.sh
在商品描述内部，对term去重，同时，清除长度小于2的term。输出进行大写化。
输出：
<cid> <1> <term> <term_num>
<cid> <0> <*> <term_num>
优化：在map中进行缓存。

cid_term_reduce.sh
对cid,term进行计数。以前三列进行分桶排序。
输出：
<cid> <1> <term> <term_num>
<cid> <0> <*> <term_num>

tf_map.sh
以cid_term_reduce的输出为输入。
cat

tf_reduce.sh
以第一列cid进行分桶，以前两列进行排序。
输出：
<cid> <term> <*_num> <term_num> <tf_score>

idf_map.sh
以tf_reduce的输出为输入。
输出：
<term> <cid> <*_num> <term_num> <tf_score>

idf_reduce.sh
以term进行分桶。
输出：
<term> <cid> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf>

cid_map.sh
以cid_term_reduce的输出为输入。只输出标识为0的行。
输出：
<*> <cid> <term_num>

cid_reduce.sh
对cid进行记数，枚举输出。
<cid> <cid_count> <term_num>

tfidf_map.sh
以cid_reduce与idf_reduce的输出作为输入。
输出：
<cid> <0> <cid_count> <term_num>
<cid> <1> <term> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf>

tfidf_reduce.sh
以cid分桶，以前两列排序。
输出：
<cid> <term> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf> <cid_count> <tfidf_cid> <tfidf_tf>

topn_map.sh
对每个cid求取tfidf的topn个term。
输出：
<cid> <CID> <int(tfidf_cid)> <cid> <term> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf> <cid_count> <tfidf_cid> <tfidf_tf>
<cid> <TF> <int(tfidf_tf)> <cid> <term> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf> <cid_count> <tfidf_cid> <tfidf_tf>

topn_reduce.sh <topn> <rho>
以前两列分桶，前三列排序。
输出：
<cid> <term> <*_num> <term_num> <tf_score> <sigma_cid> <sigma_tf> <cid_count> <tfidf_cid> <tfidf_tf> <TF|CID>

item_filter_map.sh
利用tfidf值对训练集合进行过滤。
输出：
<cid> <00-99> <0> <term> <score> <TF|CID>
<cid> <00-99> <1> <id> <WORDSEG> <cid> <desc>

item_filter_reduce.sh <topn> <rho>
以前两列分桶，以前三列排序。
输出：
<id> <WORDSEG> <cid> <desc>


执行：
dcs job.xml 1>msg 2>err&
dcs job_filter.xml topn=100 rho=0.01 1>msg.filter 2>err.filter&
