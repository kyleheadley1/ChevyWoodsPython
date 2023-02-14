import os
cwd = os.getcwd()
cwdfiles = os.listdir(cwd)

for file in cwdfiles:
    path = os.path.join(cwd, file)
    file_attr = os.stat(path)

    mydict = { 
        'file' : file, 
        'size' : file_attr.st_size,
        'path' : path
    }
    print(mydict)


