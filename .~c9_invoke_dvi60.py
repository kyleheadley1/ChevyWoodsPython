#Access os module, define variables for Working directory and files in directory
import os
wd = os.getcwd()
wdfiles = os.listdir()
#for loop with path defined and dictionary created
for file in wdfiles:
    path = os.path.join(wd, file)
    mydict = { 
        'name' : file, 
        'size' : os.path.getsize(file),
        'path' : path
    }
    print(mydict)

print(os.listdir())
