#!/bin/bash

# Train segmenter models
mkdir -p models

ORCA=~/repos/chinese_orca
CORES=4  # number of cores to use for Apertium (and others?)
APERTIUM=~/apertium/branches/tokenisation
YANSHAO=~/repos/yanshao_chinese_segmenter
ZPAR=~/repos/zpar


# echo "training Apertium model..."
# cat ${APERTIUM}/dict/zh_CN.txt | python3 ${ORCA}/tools/trad2simp.py > ${APERTIUM}/dict/zh_CN_simp.txt
# python3 ${APERTIUM}/train.py -d ${APERTIUM}/dict/zh_CN_simp.txt \
# 							 -t ${ORCA}/models/apertium-ctb-train-simp.model \
# 							 -i ${ORCA}/CTBsegs/ctb-train-simp-running.txt \
# 							 -j ${CORES}
# 
# TODO build different dictionary for Apertium? probably not

echo "training model for yanshao, tiedemann & nivre..."
mkdir -p ${YANSHAO}/ctb8
cp ${ORCA}/CTBsegs/ctb-train-simp-tagged.txt ${YANSHAO}/ctb8/train.txt
cp ${ORCA}/CTBsegs/ctb-dev-simp-tagged.txt ${YANSHAO}/ctb8/dev.txt
cp "${ORCA}/CTBsegs/ctb-test-simp-tagged.txt" "${YANSHAO}/ctb8/test.txt"
pushd ${YANSHAO}
python tagger.py train -p ctb8 -t train.txt -d dev.txt -wv -cp -rd -gru -m ctb8 -emb Embeddings/glove.txt -tg seg
popd
cp ${YANSHAO}/ctb8/ctb8* models/yanshao/
cp ${YANSHAO}/ctb8/checkpoint models/yanshao/  # is this necessary?


# echo "training Zpar model..."
# mkdir -p models/zpar
# pushd models/zpar
# ${ZPAR}/dist/segmentor/train ${ORCA}/CTBsegs/ctb-train-simp-segmented.txt ${ZPAR}/zpar-ctb-train-simp.model 1
# popd
# 
