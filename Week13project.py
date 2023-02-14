import os


list = os.listdir()

for item in list:
    dict = {item : os.path.getsize(item)}
    print(dict)


list = ['Ant', 'Super', 'Bat', 'Red']
print(list)
for item in list:
    print(item + 'man')