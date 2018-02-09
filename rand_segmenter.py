"""Parse spaceless text randomly."""

from random import random
from statistics import mean
from sys import stdin

MAX_WORD_LEN = 5

in_text = (c for c in stdin.read())  # generator object

out_text = next(in_text)  # start with character (not a space)
word_len = 1
while True:
    if random() > 0.55:
        try:
            out_text += next(in_text)
            word_len += 1
        except StopIteration:  # means the generator is empty
            break
        if word_len >= MAX_WORD_LEN:
            try:
                out_text += ' ' + next(in_text)
            except StopIteration:  # means the generator is empty
                break
    else:
        try:
            out_text += ' ' + next(in_text)
        except StopIteration:  # means the generator is empty
            break

print(out_text)
print('mean word length:', mean([len(w) for w in out_text.split()])) 
