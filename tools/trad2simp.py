from sys import stdin

from hanziconv import HanziConv

for line in stdin:
    print(HanziConv.toSimplified(line), end='')  # noqa
