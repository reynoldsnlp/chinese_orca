import sys

in_file = sys.argv[1]

with open(in_file.strip()) as f:
  list_str = f.read().strip()
  list1 = eval(list_str)
print(' '.join(list1))
