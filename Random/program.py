import random

# create set (can only contain distinct elements)
x = set()

# iterate until the set contains 100.000 elements
while len(x) < 100000:
    # generate random integer number in int32 range
    r = random.randint(-2147483648, 2147483647)
    # add it to the set (automatically checks for uniqueness)
    x.add(r)

# open file and write results
with open('result.txt', 'w') as fp:
    # to print in a row by row fashion
    for r in x:
        fp.write("%s\n" % r)
