# lambda
from tokenize import single_quoted


def another_double(x): return 2*x
print(another_double(4))
def my_print(message="default"):
    print(message)

my_print("test")
my_print()

def full_name(first="firstname",last="lastname"):
    return print(first + " "+ last)

full_name()
full_name("john","smith")

full_name(last="smith")
# Strings
single_quoted_string='data'
double_quoted="data"

not_tabl_string = r"\t"
print(len(not_tabl_string))

multi_line_string = """test
                    123
                    123"""
# string format
a = "test"
b ="test2"
c = "{0} {1}".format(a,b)
print(c)
d = f"{a} {b}"
print(d)

try:
    print (0/0)
except ZeroDivisionError:
    print("nie mozna dzielic przez zero")
# lists

integers = [1,2,3]
heterogenereous_list = ["string", 0.1, True]
print(heterogenereous_list)
list_of_lists = [integers, heterogenereous_list]
print(list_of_lists)
list_length= len(list_of_lists)
print(list_of_lists[0])
print(list_of_lists[-1])
first_two = integers[:2]
print(first_two)
integers.extend([1,2,3])
last_three = integers[-3:]
print(last_three)

integers2 = [1,2,3,4,5,6,7,8,9]
print(integers2[::3]) # every third value
print(integers2[::2])
print(1 in [1,2,3])
p=print
p(2*2)
# tuple -immutable list
tuple = (1,2,3,4)
p(tuple)
tuple2 = 1,2,3
p(tuple2)
try:
    tuple2[1] = 2
except TypeError:
    p("tuple!")

def sum_and_product(x,y):
    return (x+y),(x*y)

sp = sum_and_product(2,3)
p(sp)

s,v = sum_and_product(5,10)
x,y = 1,2

empty_dict={}
empty_dict2=dict()
grades = {"Joel":80, "Tim":95}

joels_grade = grades["Joel"]

try:
    kates_grade = grades["Joel"]
except KeyError:
    p("error")

joels_grade = grades.get("Joel", 0)
p(joels_grade)