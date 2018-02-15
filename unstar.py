"""Remove cg-conv stars that show missingness."""

import re
import sys

print(re.sub(r'(\s)\*(\w)', '\1\2', sys.stdin.read()), end='')
