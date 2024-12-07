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

grades["Tim"] = 99
p(len(grades))
tweet = {
    "user" : "joelgrus",
    "text" : "data science bla bla"
}
p(tweet)

p(grades.keys())
p(tweet.values())
p(tweet.items())
p("user" in tweet.keys())
p("user" in tweet)
p("joelgrus" in tweet.values())
# word counter
text = "test blabla test test test blabla"

document = text.split(" ")

word_counts = {}
for word in document:
    if word in word_counts:
        word_counts[word] +=1
    else:
        word_counts[word] = 1
p(word_counts)

# word coiunter v2
word_counts2 = {}
for word in document:
    try:
        word_counts2[word] +=1
    except KeyError:
        word_counts2[word] = 1
# v3
word_counts3 = {}
for word in document:
    previous_count = word_counts3.get(word,0) # if doesn't exists then set default value
    word_counts3[word] = previous_count + 1

# defaultdics
from collections import defaultdict
word_counts4 = defaultdict(int)
for word in document:
    word_counts4[word] +=1

dd_list = defaultdict(int) #
p(dd_list)
dd_list = defaultdict(list) # empty list

dd_list[2].append(1)
p("dd_list: ", dd_list)
dd_dict = defaultdict(dict) # empty map
dd_dict["Joel"]["City"] = "Seattle"

dd_pair = defaultdict(lambda: [0,0])
dd_pair[2][1] = 1
# Counter
from collections import Counter
c = Counter([0,1,2])
word_counts5 = Counter(document)

for word, count in word_counts5.most_common(10):
    print(word, count)

# Sets, unique values
primes_below_10 = {2,3,5,7}
s = set()
s.add(1)
s.add(2)
s.add(2)
p(s) # 1,2

x = len(s)
p(x)

y=2 in s
z = 3 in s

stopwords_list = ["a", "an" ,"at"]
p("zip" in stopwords_list)
p("a" in stopwords_list)

stopwords_set = set(stopwords_list)
p("zip" in stopwords_set)

item_list = [1,2,3,1,2,3]
num_items = len(item_list)
p(num_items)
item_set = set(item_list)
p(item_set)

