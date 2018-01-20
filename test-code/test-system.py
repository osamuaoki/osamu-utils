#!/usr/bin/python3
# vim:se tw=0 sts=4 ts=4 et ai:
import subprocess
from pprint import pprint

a = subprocess.run('echo "FGH"', shell=True, check=True, stdout=subprocess.PIPE)
b = a.returncode
c = a.stdout
pprint (a)
pprint (b)
pprint (c)

a = subprocess.run('exit 0', shell=True, check=True, stdout=subprocess.PIPE)
b = a.returncode
c = a.stdout
pprint (a)
pprint (b)
pprint (c)

a = subprocess.run('exit 1', shell=True, stdout=subprocess.PIPE)
b = a.returncode
c = a.stdout
pprint (a)
pprint (b)
pprint (c)
d = a.check_returncode()
print('fgtrdf')
