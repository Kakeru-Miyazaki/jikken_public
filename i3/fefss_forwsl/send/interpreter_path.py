import sys
args = sys.argv
all = args[1]
list = all.split('/')
print(all[1:-len(list[-1])])
