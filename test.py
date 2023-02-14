import os
my_dir = os.getcwd()
file_list = os.listdir(my_dir)

for file in file_list:
    file_path = os.path.join(my_dir, file)
    file_attr = os.stat(file_path)
    
    my_dict = {
        'path' : file_path,
        'file' : file,
        'size' : file_attr.st_size
    }
    print(my_dict)