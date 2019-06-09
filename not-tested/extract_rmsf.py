#!/usr/bin/env python3

import os

step_size = 5000
start_time = 117000
stop_time = 200000

for i in range (start_time, stop_time, step_size):
	#print(i)
	string = "echo 4 | "+ "g_rmsf -s em.tpr -f md_1-cat-fit.xtc -o rmsfs\/groove_117-200\/"+str(i)+".xvg "+ "-b "+ str(i)+ " -e "+ str(i+step_size) +" -res"
	os.system(string)