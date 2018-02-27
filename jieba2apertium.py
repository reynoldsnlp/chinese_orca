"""Convert jieba dictionary to apertium tokeniser dictionary."""

import sys

j2a = {}
with open('jieba2apertium.csv') as j2a_file:
    for line in j2a_file:
        j, a = line.split()
        j2a[j] = a

for line in sys.stdin:
    tok, freq, pos = line.split()
    print(tok + ':' + tok + '<' + j2a[pos] + '>')
