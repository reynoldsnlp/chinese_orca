"""Convert jieba dictionary to apertium tokeniser dictionary."""

import sys

j2a = {}
with open('jieba2apertium.csv') as j2a_file:
    for line in j2a_file:
        j, a = line.strip().split(',')
        j2a[j.lower()] = a

with open('j2a.dict', 'w') as j2ad:
    for line in sys.stdin:
        tok, freq, pos = line.split()
        try:
            print(tok + ':' + tok + '<' + j2a[pos.lower()] + '>', file=j2ad)
        except KeyError:
            print(tok + ':' + tok + f'<BADTAG_{pos}>', file=j2ad)

