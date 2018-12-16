import sys,os

f = open("./images.txt", "w+")
for i in range(1, 5001):
		# Change this as needed!!!!
		prefix = "/path/to/images/"
		suffix = ".jpg"
		#print prefix + str(i) + suffix
		f.write(prefix + str(i).zfill(7) + suffix + "\n")

f.close()
	
