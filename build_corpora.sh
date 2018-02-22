#!/bin/bash

# Building CTB files
python3 clean_ctb.py
mkdir -p CTBsegs
cat ctb8.0/data/segmented/*.txt > CTBsegs/ctb-all-simp-segmented.txt
cat CTBsegs/ctb-all-simp-segmented.txt | sed 's/ //g' > CTBsegs/ctb-all-simp-running.txt
cat CTBsegs/ctb-all-simp-segmented.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-segmented.txt
cat CTBsegs/ctb-all-simp-running.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-running.txt


# Building UD files
for each in ~/repos/UD_Chinese/*.conllu
do
	# extract spaceless sentences
	egrep "^# text = " ${each} | sed 's/^# text = //g' | tr -d " " > $(echo ${each} | sed 's/^.*Chinese\/zh-ud/UDsegs\/UD/g' | sed 's/\.conllu/-trad-running.txt/g')
	# extract segmented sentences
	egrep -v "^# (text|sent_id)" ${each} | egrep -v "^$" | cut -f 2 | tr '\n' ' ' > $(echo ${each} | sed 's/^.*Chinese\/zh-ud/UDsegs\/UD/g' | sed 's/\.conllu/-trad-segmented.txt/g')
done

for subcorp in train "test" dev; do
	cat UDsegs/UD-${subcorp}-trad-running.txt | python3 tools/trad2simp.py > UDsegs/UD-${subcorp}-simp-running.txt
	cat UDsegs/UD-${subcorp}-trad-segmented.txt | python3 tools/trad2simp.py > UDsegs/UD-${subcorp}-simp-segmented.txt
done
