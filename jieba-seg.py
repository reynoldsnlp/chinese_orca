import sys
import jieba

in_file_name = sys.argv[1]
with open(in_file_name) as f:
    corpus = f.read()

seg_list = jieba.cut(corpus, cut_all=False)
jie = ' '.join(seg_list)
print(jie)
