# Page 165
from contextlib import nullcontext

my_String = 'JavaKing'
print(my_String)
print(type(my_String))

intValue = 1
print(type(intValue))

float = 1.5
print(type(float))
# Arrays explorations freestyle
array = [1,2,3]
print(array)
print(type(array))
copy_array = array.copy()
# mutable arrays
copy_array.reverse()
print(copy_array)

copy_array.pop(2)
print(copy_array)
# copy_array.pop(2) # generete index error
try:
    copy_array.pop(2)
except IndexError:
    print("Index out of range")

strings = ['a','b']
for e in strings:
    print(e + '->' + e.upper())
# end arrays

my_bool = True
print(my_bool)
print(type(my_bool))


