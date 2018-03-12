#!/bin/bash

# still need fnlp to work
# java -Xmx1024m -Dfile.encoding=UTF-8 -classpath "fnlp-core/target/fnlp-core-2.1-SNAPSHOT.jar:libs/trove4j-3.0.3.jar:libs/commons-cli-1.2.jar" org.fnlp.nlp.cn.tag.CWSTagger -f seg.m ~/Documents/chinese_orca/CTBsegs/ctb-all-trad-running.txt ~/Documents/chinese_orca/CTBsegs/fnlp-trad-segmentedTEST.txt

for each in UDsegs/ud-simp-running.txt UDsegs/ud-trad-running.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 2)

  # fnlp_out=CTBsegs/fnlp-${chars}-segmentedTEST.txt
  # java -Xmx1024m ...

  jieba_out=UDsegs/jieba-${chars}-segmentedTEST.txt
  python3 jieba-seg.py ${each} > ${jieba_out}

  random_out=UDsegs/random-${chars}-segmentedTEST.txt
  cat ${each} | python3 rand_segmenter.py > ${random_out}

  stanford_ctb_out=UDsegs/stanford_ctb-${chars}-segmentedTEST.txt
  bash stanford-segmenter-2017-06-09/segment.sh ctb ~/Documents/chinese_orca/UDsegs/ud-${chars}-running.txt UTF-8 0 > ${stanford_ctb_out}

  stanford_pku_out=UDsegs/stanford_pku-${chars}-segmentedTEST.txt
  bash stanford-segmenter-2017-06-09/segment.sh pku ~/Documents/chinese_orca/UDsegs/ud-${chars}-running.txt UTF-8 0 > ${stanford_pku_out}

done


for each in UDsegs/ud-nostar-trad-running.txt UDsegs/ud-nostar-simp-running.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 3)

  apertium_out=UDsegs/apertium-${chars}-segmentedTEST.txt
  python3 ~/apertium/branches/tokenisation/tokenise.py -d ~/apertium/branches/tokenisation/dict/zh_CN.txt -t ~/apertium/branches/tokenisation/zh.probabilities -i ${each} | cg-conv -aP | sed s'/\*//g' > ${apertium_out}

done


for each in UDsegs/*segmentedTEST.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 2)
  python3 evalsegmenter.py ${each} UDsegs/ud-${chars}-segmented.txt
done
