name = 'butterworth_hpf_step'

'''
step用
一行目(name)を扱いたいファイル名にする
拡張子(.txt)をつけないことに注意
グラフを同名で保存(.png)
タイトルはnameになる
'''


import math
import matplotlib
import matplotlib.pyplot as plt
plt.clf()
matplotlib.use('Agg')
fname = name + '.txt'

file = open(fname, encoding='utf-8')

# a,b って2配列使ってるのは、今後.txt読み込んだだけの生データ欲しい場合にいじりやすいように
a = []
b = [[],[]]
file.readline()

for row in file:
        freq, val = row.split()
        a.append(list(map(float,(freq,val))))
        if(len(a) > 1 and a[-1][0] < 0.001045): #ここのif文をいじってグラフの範囲を変える！
            b[0].append(a[-1][0]*1000000)
            b[1].append(a[-1][1])


plt.plot(b[0], b[1])
ax = plt.gca()
ax.spines['top'].set_color('none')

plt.title(str(name),y=-0.3,fontsize=18) 
plt.xlabel('time [μs]',fontsize=15)
plt.ylabel('voltage [V]',fontsize=15)

plt.grid(which="both") # "both"でxy軸両方にgrid

#plt.show() # <- 多分いらない
plt.savefig(name+'.png', bbox_inches='tight')
