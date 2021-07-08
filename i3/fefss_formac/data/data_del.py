import sys
delnum = int(sys.argv[1])
n = int(input())
if (not (0 <= delnum < n)):
    print('Error: that data is not exits.',file=sys.stderr)
    sys.exit(1)
if (n == 0):
    print('Error: no data exists.', file=sys.stderr)
    sys.exit(1)
newn = n-1
print(newn)
for i in range(n):
    tmp = input()
    if (i != delnum):
        print(tmp)


