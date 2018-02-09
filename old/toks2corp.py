import sys
# from pprint import pprint

in_file = sys.argv[1]

simple_corp = ""

with open(in_file) as f:
    corpus = f.readlines()
    for l in corpus:
        simple_corp += l.rstrip()

print(simple_corp)
