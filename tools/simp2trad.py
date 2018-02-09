from sys import stderr
from sys import stdin
from sys import stdout

from hanziconv import HanziConv

stdout.write(HanziConv.toTraditional(stdin.read()))
# for line in stdin:
#     print(line.rstrip(), line.encode('unicode-escape'), file=stderr)
#     print(HanziConv.toTraditional(line), end='')  # noqa
