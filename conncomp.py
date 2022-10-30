#connected component using bfs
G=[]
file=open('input.txt','r')
for line in file:
	line=line.strip()
	adjacentVertices=[]
	first=True
	for node in line.split(' '):
		if first:
			first=False
			continue
		adjacentVertices.append(int(node))
	G.append(adjacentVertices)
file.close()
print(G)
def dfs(i,v):
	v[i]=1
	for j in range (len(G[i])):
		if v[G[i][j]]==-1:
			dfs(G[i][j],v)
		else:
			continue
count=0
v=[-1 for i in range(len(G))]
for i in range(len(G)):
	if v[i]==-1:
		dfs(i,v)
		count+=1
print(count)