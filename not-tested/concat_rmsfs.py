#!/usr/bin/env python3

import os
import csv

files = []
numbers = []
filename_sorted = []

files = os.listdir()

for i in range(len(files)):
	numbers.append(int(files[i][0:-4]))

numbers.sort()
#print(numbers)

for i in numbers:
	filename_sorted.append(str(i)+".xvg")
	#print(filename)
#print(filename_sorted)

row = 78
col = len(files)
matrix = [0 for i in range(row)]
for i in range(len(matrix)):
	matrix[i] = [1 for j in range(col)]

column_count = 0

for i in filename_sorted:
	f = open(i,"r")
	lines=f.readlines()
	row_count = 0
	for j in range(12,len(lines)):
		matrix[row_count][column_count]=float(str(lines[j][8:]).rstrip())
		row_count += 1
	column_count += 1
f.close()

csv_out = open('rmsf.csv','w')
wr = csv.writer(csv_out)
wr.writerows(matrix)
csv_out.close()