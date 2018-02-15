"""Remove cg-conv stars that show missingness."""

import re
import sys

for line in sys.stdin:
    print(re.sub(r'(\s)\*(\w)', r'\1\2', line), end='')
