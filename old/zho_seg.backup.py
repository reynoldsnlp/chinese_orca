"""Compare Jieba and Apertium segmenters' accuracy on the UD gold standard"""

import pprint
import jieba

################################################################################
# access the UD corpus
# grab input sentence and the correct segmentations

# loop over corpus at the sentence level?:
    # raw sentence > segmenters
    # list(segment) > s_and_c
    # s_and_c lists > comparison function

# from UD corpus the raw sentence
sen = '同樣,施力的大小不同,引起的加速度不同,最終的結果也不一樣,亦可以從向量的加成性來看.'

ud = ['同樣', ',', '施力', '的', '大小', '不同', ',', '引起', '的', '加速', '度',
      '不同', ',', '最終', '的', '結果', '也', '不', '一樣', ',', '亦', '可以',
      '從', '向量', '的', '加成', '性', '來', '看', '.']


################################################################################
# STEP run the apertium segmenter


################################################################################
# STEP run the jieba segmenter

    # a_list = jieba.lcut(sentence, cut_all=False)
    # print("Accurate Mode: " + "/ ".join(a_list))
    # print('\n')

# what i want:
seg_list = jieba.cut(sen, cut_all=False)
jie = [i for i in seg_list]
print(jie)
print('\n')

################################################################################
# STEP transform UD, Jieba, and Apertium data in ['s', 'c', 's' ... ] format

# temp_ud = ['AB', 'C', 'DEF', 'G', 'HIJKL', 'MN', 'O', 'PQ', 'R']
# temp_ng = ['AB', 'BC', 'CD', 'DE', 'EF', 'FG', 'GH', 'HI', 'IJ', 'JK', 'KL', 'LM', 'MN', 'NO', 'OP', 'PQ', 'QR']
# temp_v2 = ['s', 'c', 's', 's', 'c', 'c', 's', 's', 'c', 'c', 'c', 'c', 's', 'c', 's', 's', 'c', 's', 's']


def s_and_c(ls):
    """Transforms list(segmentation) into n-grammed and decision-labeled format.

    ['AB', 'C', 'DEF', ... ] > ['s', 'c', 's', 's', 'c', ... ]

    """

    v2 = ['s']  # start with an 's' (and end with one)

    for i in ls:
        if len(i) == 1:
            v2.append('s')  # only 1 because each combine adds its own
        elif len(i) > 1:
            for j in range(len(i) - 1):
                v2.append('c')
            v2.append('s')

    print(v2)
    # print(temp_v2)

    # if v2 == temp_v2:
        # print('\n' + 'Success!' + '\n')
    # else:
        # print('\n' + 'Nope.' + '\n')


s_and_c(ud)

s_and_c(jie)


# if ls[-1] == i:
    # v2.append('s')

def find_ngrams(input_list, n):
    return zip(*[input_list[i:] for i in range(n)])  # returns zip gen obj


def transform(ls):  # ls == list(sentence)
    ngrams = find_ngrams(ls, 2)
    print('\n')
    for i in ngrams:
        print(list(i))
    print('\n')
    udlist = [list(i) for i in ud]
    print(udlist)
    print('\n')
    # v2 = ['s']
    # for n in ngrams:
    #     if n is in udlist:




# transform(list(sentence))



# def transform(ls):
    # v2 = ['s']  # start with a separate
    # for i in ls:
        # if len(i) == 1:
            # for i in range(2):
                # v2.append('s')
        # elif len(i) == 2:
            # v2.append('c')
        # elif len(i) == 3:
            # for q in range(2):
                # v2.append('c')
    # print(v2)

# v2 = 's'.join(ls)
# for i in v2:
#     if i != 's': i = 'c'
# print(v2)

# v2 = 's'.join(ls)
# v3 = list(v2)

# v4 = [i if i == 's' else 'c' for i in v3]
# returns 'c' for every non-'s', needs to be 'c' for every consecutive without spaces AAA ('c', 'c')

# for i in v3

# print(v4)

# def find_ngrams(input_list, n):
    # return zip(*[input_list[i:] for i in range(n)])


################################################################################
# compare using list comprehension

    # good = ['s', 'c', 's', 's', 'c', 's', 's', 'c', 's', 'c', 's', 's', 'c', 's', 's', 'c', 's', 's']
    # badd = ['s', 'c', 's', 's', 'c', 's', 's', 'c', 's', 'c', 's', 's', 'c', 'c', 's', 'c', 'c', 's']
    # retu = [i for i, j in zip(good, badd) if i == j]
    # // retu = ['s', 'c', 's', 's', 'c', 's', 's', 'c', 's', 'c', 's', 's', 'c', 's', 'c', 's']
    # // len(retu) over len(good) == accuracy percentage on sentence level

################################################################################
# show the results
