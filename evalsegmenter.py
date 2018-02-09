"""Take any segmenter's predictions (in the form of a spaced text file),
and compare it against any given gold standard spaced file, returning
pure accuracy"""

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

# turn into lists for evalutaion and remove newlines
test_list = in_file.split(' ')
test_list = [re.sub(r'\n', '', token) for token in test_list]

gold_list = gold_file.split(' ')
gold_list = [re.sub(r'\n', '', token) for token in gold_list]


def s_and_c(ls):
    return 's'.join(['c' * (len(i) - 1) for i in ls])


sc_test_segs = s_and_c(test_list)
sc_gold_segs = s_and_c(gold_list)

# compare the two
num_right = len([i for i, j in zip(sc_gold_segs, sc_test_segs) if i == j])
accuracy = num_right / len(sc_gold_segs)

# assuming filename format "segmenter-trad|simp-segmented.txt"
segmenter_filename_ls = in_filename.split('-')
segmenter = segmenter_filename_ls[0]

# assuming filename format "corpus-trad|simp-segmented.txt"
gold_filename_ls = gold_standard_filename.split('-')
gold = gold_filename_ls[0]

chars = segmenter_filename_ls[1]

print('\n')
print('The ' + segmenter + ' segmenter scored ', end='')  # noqa
print(round(accuracy, 4), end='')
print(" against the " + gold + "'s gold standard (" + chars + ") segmentations.")  # noqa
print('\n')
