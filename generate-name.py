import sys,os

f = open("/tmp/darknet/data/train.txt", "w+")
for i in range(1, 5001):
		# Change this as needed!!!!
		prefix = "/home/teddyxu/african/"
		suffix = ".jpg"
		#print prefix + str(i) + suffix
		f.write(prefix + str(i).zfill(7) + suffix + "\n")

f.close()
	
