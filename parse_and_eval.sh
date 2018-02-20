#!/bin/bash

corpus=$1
short_corpus=$(echo $1 | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1)
parser=$2
gold=$3

apertium="python3 ${HOME}/apertium/branches/tokenisation/tokenise.py"
fnlp="java -c ..."
jieba="python3 jieba-seg.py"
stanford_ctb="java -c ..."
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
