#!/bin/sh
# vim:se tw=78 sts=4:
# Copyright (C) Osamu Aoki <osamu@debian.org>, GPL2+
set -e

#endwith () {
#f="$1"
#g="$2"
#h=${f%$g}
##echo "-----------"
##echo "$f"
##echo "-----------"
##echo "$g"
##echo "-----------"
##echo "$h"
##echo "-----------"
#if [ "$f" != "$h" ]; then
#    # endwith $g
#    return 0
#else
#    # not endwith $g
#    return 1
#fi
#}
#hidden () {
#f=$(basename "$1")
#h=${f#.}
#if [ "$f" != "$h" ]; then
#    # start with .
#    return 0
#else
#    # not start with .
#    return 1
#fi
#}

endwith () {
[ "$1" != "${1%$2}" ] && return 0 || return 1
}
hidden () {
f=$(basename "$1")
[ "$f" != "${f#.}" ] && return 0 || return 1
}

file="$1"
ending='~'
if endwith "$file" "$ending" ; then
    echo "YES, '$file' ends with '$ending'"
else
    echo "NO, '$file' doesn't end with '$ending'"
fi
if hidden "$file" ; then
    echo "YES, '$file' is hidden file"
fi
if ! hidden "$file" ; then
    echo "NO, '$file' isn't hidden file"
fi


