#!/usr/bin/python3
# vim:se tw=0 sts=4 ts=4 et ai:
import hashlib
import operator
from pprint import pprint

data = '  ahjdashdkj   sdSAD DAASDAD    saDDS\n\nqweqwqqwqewq  '

def test():
    datax = data
    print('Before:')
    pprint(datax)
    datay =datax.split()
    print('After:')
    pprint(datay)


###############################################################################
if __name__ == '__main__':
    test()
