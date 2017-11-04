#!/usr/bin/python3
# vim:se tw=0 sts=4 ts=4 et ai:
import hashlib
import operator
from pprint import pprint

data = [
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'ahjdashdkjhjkdhjskDHJKHD;FH;JSKDJKDJKS;DJK;jd',
    'aA']

def test():
    datax = data
    pprint(datax)
    m = hashlib.md5()
    for s in datax:
        m.update(s.encode())
        print('{}'.format(m.hexdigest()))
    print('FINAL={}'.format(m.hexdigest()))


###############################################################################
if __name__ == '__main__':
    test()
