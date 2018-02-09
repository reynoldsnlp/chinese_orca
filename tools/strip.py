"""Remove \n """

import sys

stripped = ''

in_file_name = sys.argv[1]
with open(in_file_name) as f:
    corpus = f.read()

for i in corpus:
    if i != "\n":
        stripped += i

print(stripped)
