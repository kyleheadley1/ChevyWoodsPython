import os
cwd = os.getcwd()
cwdfiles = os.listdir(cwd)

for file in cwdfiles:
    path = os.path.join(cwd, file)
    mydict = { 
        'name' : file, 
        'size' : os.path.getsize(file),
        'path' : path
    }
    print(mydict)


