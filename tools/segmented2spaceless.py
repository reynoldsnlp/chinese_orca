"""Takes a file of spaced text and turns it into running text for passing to
segmenters for evaluation"""

import re
import sys

in_file = sys.argv[1]

with open(in_file) as f:
    print(re.sub(r'[ \n]', '', f.read()))
