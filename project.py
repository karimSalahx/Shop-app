#install tsp library using command pip install tsp
import tsp
# initialize the matrix we need to search for the shortest path in
matrix = [[1,2,3,4] , [5,6,7,8] , [9,10,11,12] , [13,14,15,16]]
r = range(len(matrix))
# i visits all the rows of matrix and j visits all columns of matrix
shortestPath = {(i,j):matrix[i][j] for i in r for j in r}
print(tsp.tsp(r,shortestPath))