"""Remove xml tags from CTB corpus."""

from glob import glob
import re

from bs4 import BeautifulSoup

for filename in glob('ctb8.0/data/segmented/*.seg'):
    with open(filename) as seg_file, open(filename + '.txt', 'w') as out_file:
        # soup = BeautifulSoup(seg_file, 'lxml-xml')
        for line in seg_file:
            if not re.match(r'\s*<', line) and line.strip() != '':
                print(line, end='', file=out_file)
