#!/bin/bash

echo "Building CTB files..."
echo "    ...splitting into train and test..."
python3 build_ctb.py  # split into train and test (includes cleaning like clean_ctb.py)
echo "    ...cleaning combined corpus..."
python3 clean_ctb.py  # clean all files for combined corpus
echo "    ...concatenating corpora..."
mkdir -p CTBsegs
cat ctb8.0/data/segmented/*.txt > CTBsegs/ctb-all-simp-segmented.txt
cat CTBsegs/ctb-train-simp-segmented.txt | sed 's/ //g' > CTBsegs/ctb-train-simp-running.txt
cat CTBsegs/ctb-test-simp-segmented.txt | sed 's/ //g' > CTBsegs/ctb-test-simp-running.txt
cat CTBsegs/ctb-all-simp-segmented.txt | sed 's/ //g' > CTBsegs/ctb-all-simp-running.txt
echo "    ...transliterating... (simp2trad)..."
cat CTBsegs/ctb-all-simp-segmented.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-segmented.txt
cat CTBsegs/ctb-all-simp-running.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-running.txt
echo "done!"


echo "Building UD files..."
for each in ~/repos/UD_Chinese/*.conllu
do
	# extract spaceless sentences
	egrep "^# text = " ${each} | sed 's/^# text = //g' | tr -d " " > $(echo ${each} | sed 's/^.*Chinese\/zh-ud/UDsegs\/UD/g' | sed 's/\.conllu/-trad-running.txt/g')
	# extract segmented sentences
	egrep -v "^# (text|sent_id)" ${each} | egrep -v "^$" | cut -f 2 | tr '\n' ' ' > $(echo ${each} | sed 's/^.*Chinese\/zh-ud/UDsegs\/UD/g' | sed 's/\.conllu/-trad-segmented.txt/g')
done

echo "    ...transliterating... (trad2simp)..."
for subcorp in train "test" dev; do
	cat UDsegs/UD-${subcorp}-trad-running.txt | python3 tools/trad2simp.py > UDsegs/UD-${subcorp}-simp-running.txt
	cat UDsegs/UD-${subcorp}-trad-segmented.txt | python3 tools/trad2simp.py > UDsegs/UD-${subcorp}-simp-segmented.txt
done
echo "done!"
