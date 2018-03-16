Sat Jun 21 00:57:22 2008
Author: Pi-Chuan Chang
----------------------------------
Here's a documentation of how to train and test the segmenter on specific split 
range of the CTB data.

The following steps assumes you have 3 files defining the ranges of train/dev/test.
They should be named as "ctb6.train", "ctb6.dev", "ctb6.test" respectively.
The format should be like:
      chtb_0003.fid
      chtb_0015.fid
      ...
----------------------------------

[STEP 1] change the CTB6 path in the Makefile:
      CTB6=/afs/ir/data/linguistic-data/Chinese-Treebank/6/

[STEP 2] download and uncompress the lastest segmenter from:
      http://nlp.stanford.edu/software/stanford-chinese-segmenter-2008-05-21.tar.gz
and change this path in the Makefile to your local path:
      SEGMENTER=/tmp/stanford-chinese-segmenter-2008-05-21/

[STEP 3] simply type:
      make all
You can also split down into these sub-steps:
      make internaldict # make internal dictionaries for affixation feaetures
      make data         # make datasets
      make traintest    # train & test the CRF segmenter

