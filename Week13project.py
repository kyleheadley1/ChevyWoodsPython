import os
wd = os.getcwd()
wdfiles = os.listdir()

for file in wdfiles:
    path = os.path.join(wd, file)
    mydict = { 
        'name' : file, 
        'size' : os.path.getsize(file),
        'path' : path
    }
    print(mydict)


