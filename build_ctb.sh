mkdir -p CTBsegs
cat ctb8.0/data/segmented/*.txt > CTBsegs/ctb-all-simp-segmented.txt
cat CTBsegs/ctb-all-simp-segmented.txt | sed 's/ //g' > CTBsegs/ctb-all-simp-running.txt
cat CTBsegs/ctb-all-simp-segmented.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-segmented.txt
cat CTBsegs/ctb-all-simp-running.txt | python3 tools/simp2trad.py > CTBsegs/ctb-all-trad-running.txt
