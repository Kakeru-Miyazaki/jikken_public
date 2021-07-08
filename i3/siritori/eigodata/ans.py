import sys
import random
eigo=sys.argv[1]
fname = './eigodata/'+eigo+'.txt'
file = open(fname, encoding='utf-8')
anslist=[]
for row in file:
    anslist.append(row)
n=random.randrange(len(anslist))
#ans = anslist[n].split()
# print(ans[0],end="")
#print(ans[0])
#for i in range(1,len(ans)):
#    print(ans[i],end=" ")
print(anslist[n],end="")
