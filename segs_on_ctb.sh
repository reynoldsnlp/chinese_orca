#!/bin/bash

export FNLP="${HOME}/repos/fnlp/"

for each in CTBsegs/ctb-all-simp-running.txt CTBsegs/ctb-all-trad-running.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 3)

  fnlp_out=${HOME}/Documents/chinese_orca/CTBsegs/fnlp-${chars}-segmented.txt
  { time java -Xmx1024m -Dfile.encoding=UTF-8 -classpath "${FNLP}fnlp-core/target/fnlp-core-2.1-SNAPSHOT.jar:${FNLP}libs/trove4j-3.0.3.jar:${FNLP}libs/commons-cli-1.2.jar" org.fnlp.nlp.cn.tag.CWSTagger -f ${FNLP}models/seg.m ~/Documents/chinese_orca/CTBsegs/ctb-all-${chars}-running.txt ${fnlp_out} 2> CTBstderr/fnlp_${chars}.stderr ; } 2> TIME/time_fnlp_${chars}.txt

  jieba_out=CTBsegs/jieba-${chars}-segmented.txt
  { time python3 jieba-seg.py ${each} > ${jieba_out} 2> CTBstderr/jieba_${chars}.stderr ; } 2> TIME/time_jieba_${chars}.txt

  random_out=CTBsegs/random-${chars}-segmented.txt
  cat ${each} | python3 rand_segmenter.py > ${random_out}

  stanford_ctb_out=CTBsegs/stanford_ctb-${chars}-segmented.txt
  { time bash stanford-segmenter-2017-06-09/segment.sh ctb ~/Documents/chinese_orca/CTBsegs/ctb-all-${chars}-running.txt UTF-8 0 > ${stanford_ctb_out} 2> CTBstderr/stanford_ctb_${chars}.stderr ; } 2> TIME/time_stanford_ctb_${chars}.txt

  stanford_pku_out=CTBsegs/stanford_pku-${chars}-segmented.txt
  { time bash stanford-segmenter-2017-06-09/segment.sh pku ~/Documents/chinese_orca/CTBsegs/ctb-all-${chars}-running.txt UTF-8 0 > ${stanford_pku_out} 2> CTBstderr/stanford_pku_${chars}.stderr ; } 2> TIME/time_stanford_pku_${chars}.txt

done

for each in CTBsegs/ctb-nostar-trad-running.txt CTBsegs/ctb-nostar-simp-running.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 3)

  apertium_out=CTBsegs/apertium-${chars}-segmented.txt
  { time python3 ~/apertium/branches/tokenisation/tokenise.py -d ~/apertium/branches/tokenisation/dict/zh_CN_${chars}.txt -t ~/apertium/branches/tokenisation/zh-ud-train-${chars}-toks.probs  -i ${each} | cg-conv -aP | sed s'/\*//g' > ${apertium_out} 2> CTBstderr/apertium_${chars}.stderr ; } 2> TIME/time_apertium_${chars}.txt

done


for each in CTBsegs/*segmented.txt;
  do
  chars=$(echo ${each} | cut -d "-" -f 2)
  python3 evalsegmenter.py ${each} CTBsegs/ctb-all-${chars}-segmented.txt
done
