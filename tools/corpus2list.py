import sys
# from pprint import pprint

in_file = sys.argv[1]

with open(in_file) as f:
    corpus = f.read()
    ls_corp = corpus.split(" ")
    ls_corp.pop()

print(ls_corp)
