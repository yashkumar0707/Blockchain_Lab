G=[]
file=open('input.txt','r')
for line in file:
    line=line.strip()
    adjver=[]
    first=True
    for node in line.split(' '):
        if first:
            first=False
            continue
        adjver.append(int(node))
    G.append(adjver)
file.close()

time =0
pred=[-1 for i in range (len(G))]
start=[-1 for i in range(len(G))]
visited=[-1 for i in range(len(G))]
s=0
def EC(s):
    global time
    visited[s]=1
    start[s]=time
    time+=1
    sst=start[s]
    for i in G[s]:
        if visited[i]==-1:
            pred[i]=s
            sst=min(EC(i),sst)
        else:
            if pred[s]!=i:
                sst=min(sst,start[i])
    if sst==start[s] and sst!=0:
        print("not 2ec bridge edge : ",s,pred[s])
        exit()
    return sst   
EC(s)
print("EC")