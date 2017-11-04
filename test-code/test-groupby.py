#!/usr/bin/python3
# vim:se tw=0 sts=4 ts=4 et ai:
import itertools
import operator
from pprint import pprint

data = [
    ['a', 'A', 1],
    ['a', 'C', 2],
    ['a', 'B', 2],
    ['a', 'A', 1],
    ['a', 'A', 12],
    ['b', 'A', 12],
    ['n', 'A', 11],
    ['c', 'B', 1],
    ['v', 'B', 12],
    ['x', 'B', 13],
    ['z', 'B', 1],
    ['x', 'A', 1],
    ['c', 'A', 11],
    ['v', 'C', 12],
    ['x', 'C', 13],
    ['v', 'C', 14],
    ['x', 'C', 15],
    ['z', 'A', 176],
    ['a', 'A', 17]]

def test():
    grpx = []
    datax = data
    print(datax)
    datax = sorted(datax, key=operator.itemgetter(0,1,2))
    for k, v in itertools.groupby(datax, operator.itemgetter(0)):
        grpx.append(list(v))    # Store group iterator as a list
    print('=== grpx === type = {} ==='.format(type(grpx)))
    pprint(grpx)
    print('===----===')
    grpxy = []
    for v in grpx:
        grpy = []
        datay = v
        for k, v in itertools.groupby(datay, operator.itemgetter(1)):
            grpy.append(list(v))    # Store group iterator as a list
        print('=== grpy === type = {} ==='.format(type(grpy)))
        pprint(grpy)
        grpxy.append(list(grpy))
    print('=== grpxy === type = {} ==='.format(type(grpxy)))
    pprint(grpxy)


###############################################################################
if __name__ == '__main__':
    test()
