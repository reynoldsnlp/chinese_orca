CTB6=/afs/ir/data/linguistic-data/Chinese-Treebank/6/
SEGMENTER=/tmp/stanford-chinese-segmenter-2008-05-21/

all: internaldict data traintest
clean:
	rm -rf ctb6-train data models/ctb6.ser.gz

internaldict: ctb6-train/dict/character_list ctb6-train/dict/ctb.non ctb6-train/dict/in.ctb


ctb6-train/dict.ctb6-train: ctb6.train
	mkdir -p ctb6-train/dict/
	./scripts/outputPOSfile.pl $(CTB6) < $+ | ./scripts/makeWordPOSList.pl > $@

ctb6-train/dict/character_list: ctb6-train/dict.ctb6-train
	mkdir -p ctb6-train/dict/
	./scripts/makeAffixation.pl < $+ > $@

ctb6-train/dict/ctb.non: ctb6.train	
	mkdir -p ctb6-train/dict/
	./scripts/outputPOSfile.pl $(CTB6) < $+ | ./scripts/makenon.pl > $@

ctb6-train/dict/in.ctb: ctb6-train/dict.ctb6-train
	mkdir -p ctb6-train/dict/
	./scripts/makeIndependentChar.pl < $+ > $@

data: data/ctb6.train.seg data/ctb6.dev.unseg data/ctb6.test.unseg data/ctb6.train.dict

data/ctb6.train.seg: ctb6.train
	mkdir -p data
	perl -w scripts/makeDataset.pl $(CTB6) < $+ > $@

data/ctb6.dev.seg: ctb6.dev
	mkdir -p data
	perl -w scripts/makeDataset.pl $(CTB6) < $+ > $@

data/ctb6.test.seg: ctb6.test
	mkdir -p data
	perl -w scripts/makeDataset.pl $(CTB6) < $+ > $@

data/ctb6.train.dict: data/ctb6.train.seg
	perl -w scripts/makeDict.pl < $+ > $@

data/ctb6.dev.unseg: data/ctb6.dev.seg
	./scripts/unsegment-zh < $+ > $@

data/ctb6.test.unseg: data/ctb6.test.seg
	./scripts/unsegment-zh < $+ > $@

traintest: models/ctb6.ser.gz results/ctb6.dev.score results/ctb6.test.score

models/ctb6.ser.gz: train.prop
	mkdir -p models
	mkdir -p logs
	time java6 -cp $(SEGMENTER)/seg.jar -mx10g edu.stanford.nlp.ie.crf.CRFClassifier -prop train.prop -serDictionary $(SEGMENTER)/data/dict-chris6.ser.gz -sighanCorporaDict ctb6-train -trainFile data/ctb6.train.seg -serializeTo $@ > logs/ctb6.log 2> logs/ctb6.err

results/ctb6.dev.out: data/ctb6.dev.unseg
	mkdir -p results
	java -mx2g -cp $(SEGMENTER)/seg.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier models/ctb6.ser.gz -testFile -testFile $+ -serDictionary $(SEGMENTER)/data/dict-chris6.ser.gz -sighanCorporaDict ctb6-train -inputEncoding UTF-8 -sighanPostProcessing true -keepAllWhitespaces false -keepEnglishWhitespaces true > $@

results/ctb6.test.out: data/ctb6.test.unseg
	mkdir -p results
	java -mx2g -cp $(SEGMENTER)/seg.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier models/ctb6.ser.gz -testFile -testFile $+ -serDictionary $(SEGMENTER)/data/dict-chris6.ser.gz -sighanCorporaDict ctb6-train -inputEncoding UTF-8 -sighanPostProcessing true -keepAllWhitespaces false -keepEnglishWhitespaces true > $@

results/ctb6.dev.score: data/ctb6.train.dict data/ctb6.dev.seg results/ctb6.dev.out
	./scripts/score $+ > $@

results/ctb6.test.score: data/ctb6.train.dict data/ctb6.test.seg results/ctb6.test.out
	./scripts/score $+ > $@
