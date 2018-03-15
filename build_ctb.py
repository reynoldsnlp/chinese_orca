"""Divide CTB into train and test."""

from glob import glob
import re

from bs4 import BeautifulSoup

def expand(in_str):
    if ' - ' in in_str:
        span = re.findall('[0-9]+', in_str)
        nums = [str(i).zfill(4) for i in range(int(span[0]), int(span[1]) + 1)]
        return [f'chtb_{i}' for i in nums]
    else:
        return [in_str]

with open('ctb8.0/docs/gold-standard-files.txt') as gs_file:
    gs_files = [d.rstrip() for d in gs_file if d.startswith('chtb')]

gs_names = []
for i in gs_files:
    gs_names.extend(expand(i))
gs_names = set(gs_names)

train = ''
test = ''
with open('CTBsegs/ctb-train-simp-segmented.txt', 'w') as train_file, \
     open('CTBsegs/ctb-test-simp-segmented.txt', 'w') as test_file:
    for f in glob('ctb8.0/data/segmented/*.seg'):
        with open(f) as each_file:
            if re.search(r'ctb8\.0/data/segmented/(.*?)\.', f).group(1) in gs_names:
                for line in each_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=test_file)
            else:
                for line in each_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=train_file)

