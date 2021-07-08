import sys
args = sys.argv
all = args[1]
list = all.split('/')
print(list[-1][:-1])
