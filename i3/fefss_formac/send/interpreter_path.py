import sys
args = sys.argv
all = args[1]
list = all.split('/')
print(all[:-len(list[-1])])
