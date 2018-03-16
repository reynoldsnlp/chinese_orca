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
        nums = [str(i).zfill(4) for i in re.findall('[0-9]+', in_str)]
        return [f'chtb_{i}' for i in nums]

with open('ctb8.0/docs/gold-standard-files.txt') as gs_file:
    gs_files = [d.rstrip() for d in gs_file if d.startswith('chtb')]

gs_names = []
for i in gs_files:
    gs_names.extend(expand(i))
gs_names = set(gs_names)

dev_counter = 0
test_counter = 0
with open('CTBsegs/ctb-train-simp-segmented.txt', 'w') as train_file, \
     open('CTBsegs/ctb-train-simp-tagged.txt', 'w') as train_tag_file, \
     open('ctb8.train', 'w') as train_list_file, \
     open('CTBsegs/ctb-dev-simp-segmented.txt', 'w') as dev_file, \
     open('CTBsegs/ctb-dev-simp-tagged.txt', 'w') as dev_tag_file, \
     open('ctb8.dev', 'w') as dev_list_file, \
     open('CTBsegs/ctb-test-simp-segmented.txt', 'w') as test_file, \
     open('CTBsegs/ctb-test-simp-tagged.txt', 'w') as test_tag_file, \
     open('ctb8.test', 'w') as test_list_file, \
     open('CTBsegs/ctb-all-simp-segmented.txt', 'w') as all_file, \
     open('CTBsegs/ctb-all-simp-tagged.txt', 'w') as all_tag_file:
    for f in sorted(glob('ctb8.0/data/segmented/*.seg')):
        short_f = f.split('/')[-1].split('.')[0] + '.fid'
        tagged_f = f.replace('segmented', 'postagged').replace('.seg', '.pos')
        # ctb8.0/data/segmented/chtb_0044.nw.seg
        with open(f) as seg_file, open(tagged_f) as tag_file:
            if re.search(r'ctb8\.0/data/segmented/(.*?)\.', f).group(1) in gs_names:
                print(short_f, file=test_list_file)
                test_counter += 1
                for line in seg_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=test_file)
                        print(line, end='', file=all_file)
                for line in tag_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=test_tag_file)
                        print(line, end='', file=all_tag_file)
            elif dev_counter < test_counter:
                print(short_f, file=dev_list_file)
                dev_counter += 1
                for line in seg_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=dev_file)
                        print(line, end='', file=all_file)
                for line in tag_file:
                    if not re.match(r'\s*<', line) and line.strip() != '':
                        print(line, end='', file=dev_tag_file)
                        print(line, end='', file=all_tag_file)
            else:
                print(short_f, file=train_list_file)
                for line in seg_file:
                    if not re.match(r'\s*<', line) and line.strip() != '' and 'BULLET' not in line:
                        print(line, end='', file=train_file)
                        print(line, end='', file=all_file)
                for line in tag_file:
                    if not re.match(r'\s*<', line) and line.strip() != '' and 'BULLET' not in line:
                        print(line, end='', file=train_tag_file)
                        print(line, end='', file=all_tag_file)

