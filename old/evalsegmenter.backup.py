"""Take any segmenter's predictions (in the form of a spaced text file),
and compare it against any given gold standard spaced file, returning
accuracy, precision, and recall.

Usage:
python3 evalsegmenter.py <segmenter output file> <gold standard file>
"""

import re
import sys

# the segmenter in question's output
in_filename = sys.argv[1]
with open(in_filename) as f:
    in_file = f.read()

# the gold standard for comparison
gold_standard_filename = sys.argv[2]
with open(gold_standard_filename) as g:
    gold_file = g.read()

# replace instances of one or more whitespace of any kind with a single space
# turn into lists for evalutaion
test_list = re.sub(r'\s+', ' ', in_file)
test_list = test_list.split(' ')

gold_list = re.sub(r'\s+', ' ', gold_file)
gold_list = gold_list.split(' ')


def s_and_c(ls):
    return 's'.join(['c' * (len(i) - 1) for i in ls])


sc_test_segs = s_and_c(test_list)
sc_gold_segs = s_and_c(gold_list)

# compare the two
accuracy = len([i for i, j in zip(sc_gold_segs, sc_test_segs) if i == j]) / len(sc_gold_segs)  # noqa

precision = len([True for gold, pred in zip(sc_gold_segs, sc_test_segs)
                 if pred == 's' and gold == pred]) / sc_test_segs.count('s')
recall = len([True for gold, pred in zip(sc_gold_segs, sc_test_segs)
              if pred == 's' and gold == pred]) / (sc_test_segs.count('s') + len([True for gold, pred in zip(sc_gold_segs, sc_test_segs) if pred == 'c' and gold == 's']))  # noqa


# assuming filename format "CORPUSsegs/segmenter-trad|simp-segmented.txt"
segmenter_filename_ls = in_filename.split('-')
segmenter = segmenter_filename_ls[0]
segmenter_ls = segmenter.split('/')
segmenter = segmenter_ls[1].upper()
chars = segmenter_filename_ls[1]

# assuming filename format "CORPUSsegs/corpus-trad|simp-segmented.txt"
gold_filename_ls = gold_standard_filename.split('-')
gold = gold_filename_ls[0]
gold_ls = gold.split('/')
gold = gold_ls[1].upper()

print('\n')
print('Comparing the ' + segmenter + ' segmentations against the ' + gold + ' gold standard.')  # noqa
print('(Using ' + chars + ' characters)')
print('\n')
print('accuracy', '\t', round(accuracy, 4))
print('precision', '\t', round(precision, 4))
print('recall', '\t\t', round(recall, 4))
print('\n')
