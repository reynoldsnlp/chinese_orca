#!/bin/bash

corpus=$1
short_corpus=$(echo $1 | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1)
parser=$2
gold=$3

apertium="python3 ${HOME}/apertium/branches/tokenisation/tokenise.py -d dict/zh_CN.txt -t zh.probabilities -i ${HOME}/Documents/chinese_orca/CTBsegs/ctb-nostar-trad-running.txt | cg-conv -aP | sed s'/\*//g' > ${HOME}/Documents/chinese_orca/CTBsegs/apertium-nostar_trad-segmented.txt"
fnlp="java -c ..."
# "java -Xmx1024m -Dfile.encoding=UTF-8 -classpath "fnlp-core/target/fnlp-core-2.1-SNAPSHOT.jar:libs/trove4j-3.0.3.jar:libs/commons-cli-1.2.jar" org.fnlp.nlp.cn.tag.CWSTagger -f models/seg.m <input file> <output file>"
jieba="python3 jieba-seg.py ${HOME}/Documents/CTBsegs/ctb-all-trad-running.txt"
stanford_ctb="java -c ..."
# "./segment.sh pku path/to/input.file UTF-8 0 > path/to/segmented.file"
stanford_pku="java -c ..."

if [ $parser == apertium ]; then
	parse=${apertium}
	echo $parse
elif [ $parser == fnlp ]; then
	parse=${jieba}
	echo $parse
elif [ $parser == jieba ]; then
	parse=${jieba}
	echo $parse
elif [ $parser == stanford_ctb ]; then
	parse=${stanford_ctb}
	echo $parse
elif [ $parser == stanford_pku ]; then
	parse=${stanford_pku}
	echo $parse
else
	echo "bad parser argument. Must be in {apertium, fnlp, jieba, stanford_ctb, stanford_pku}."
fi

segmented=${parser}-${short_corpus}-segmented-TEST.txt
${parse} ${corpus} > ${segmented}

python3 evalsegmenter.py ${segmented} ${gold}
