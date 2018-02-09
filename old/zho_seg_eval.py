"""Compare Jieba and Apertium segmenters' accuracy on the UD gold standard"""

import pprint
import jieba

###############################################################################
# access the UD corpus
# grab input sentence and the correct segmentations

# loop over corpus at the sentence level?:
#   raw sentence > segmenters
#   transform correct ud segmentation into list of segs
#   list(segment) > s_and_c
#   s_and_c lists > comparison function

# raw sentence
sen = '同樣,施力的大小不同,引起的加速度不同,最終的結果也不一樣,亦可以從向量的加成性來看.'

# transformed into list of segs (same format the other results need to be in)
ud = ['同樣', ',', '施力', '的', '大小', '不同', ',', '引起', '的', '加速', '度',
      '不同', ',', '最終', '的', '結果', '也', '不', '一樣', ',', '亦', '可以',
      '從', '向量', '的', '加成', '性', '來', '看', '.']

###############################################################################
# run the apertium segmenter


###############################################################################
# run the jieba segmenter // there's a way to cut out the loading message

seg_list = jieba.cut(sen, cut_all=False)
jie = [i for i in seg_list]  # transform into list of segs format
# print(jie)
print('\n')

###############################################################################
# transform any list of segs into ['s', 'c', 's' ... ] format

'''
def s_and_c(ls):
    """Transforms list of segs into n-grammed and decision-labeled format.

    ['AB', 'C', 'DEF', ... ] > ['s', 'c', 's', 's', 'c', 'c', ... ]

    simulating [(START,'s'),('AB', 'c'), ('BC', 's'), ('CD', 's'), ...]

    """
    v2 = ['s']  # start with an 's' (and end with one)

    for i in ls:
        if len(i) == 1:
            v2.append('s')  # only 1 because each combine adds its own
        elif len(i) > 1:
            for j in range(len(i) - 1):
                v2.append('c')
            v2.append('s')

    return(v2)
'''


def s_and_c(ls):
    return 's'.join(['c' * (len(i) - 1) for i in ls])


sc_ud = s_and_c(ud)

sc_jie = s_and_c(jie)

print('Universal Dependency:')
print(sc_ud)

print('Jieba segmenter:')
print(sc_jie)

###############################################################################
# compare using list comprehension

num_right = len([i for i, j in zip(sc_ud, sc_jie) if i == j])
accuracy = num_right / len(sc_ud)

print('\n')
print('The Jieba segmenter scored: ', end='')  # noqa
print(round(accuracy, 4))
print('\n')
