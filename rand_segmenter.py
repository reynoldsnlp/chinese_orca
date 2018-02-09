"""Parse spaceless text randomly.

Test by using...
$ python3 -c "print('c'*10000)" | python3 rand_segmenter.py
"""

from collections import Counter
from pprint import pprint
from random import random
from statistics import mean
from sys import stdin
from sys import stderr

MAX_WORD_LEN = 5
PROB = 0.46  # probability that word will continue without a space

in_text = (c for c in stdin.read())  # generator object

out_text = next(in_text)  # start with character (not a space)
word_len = 1
while True:
    if random() <= PROB:  
        try:
            out_text += next(in_text)
            word_len += 1
        except StopIteration:  # means the generator is empty
            break
        if word_len >= MAX_WORD_LEN:
            try:
                out_text += ' ' + next(in_text)
                word_len = 1
            except StopIteration:  # means the generator is empty
                break
    else:
        try:
            out_text += ' ' + next(in_text)
            word_len = 1
        except StopIteration:  # means the generator is empty
            break

print(out_text, end='')
w_lens = [len(w) for w in out_text.split()]
print('mean word length:', mean(w_lens), file=stderr) 
print('word length distribution:', file=stderr)
for k, v in Counter(w_lens).items():
    print('\t', k, ': ', v, sep='', file=stderr)
