#!/bin/bash

# Train segmenter models
mkdir -p models

CORES=4  # number of cores to use for Apertium (and others?)
ORCA=~/repos/chinese_orca
ZPAR=~/repos/zpar
APERTIUM=~/apertium/branches/tokenisation


echo "training Zpar model..."
mkdir -p models/zpar
cd models/zpar
${ZPAR}/dist/segmentor/train ${ORCA}/CTBsegs/ctb-train-simp-segmented.txt ${ORCA}/models/zpar-ctb-train-simp.model 1
cd ../..

echo "training Apertium model..."
cat ${APERTIUM}/dict/zh_CN.txt | python3 ${ORCA}/tools/trad2simp.py > ${APERTIUM}/dict/zh_CN_simp.txt
python3 ${APERTIUM}/train.py -d ${APERTIUM}/dict/zh_CN_simp.txt \
							 -t ${ORCA}/models/apertium-ctb-train-simp.model \
							 -i ${ORCA}/CTBsegs/ctb-train-simp-running.txt \
							 -j ${CORES}

echo "training model for yanshao, tiedemann & nivre..."
cd models/yanshao
echo "    ...not done yet."
cd ../../

