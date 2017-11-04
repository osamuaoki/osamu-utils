#!/bin/sh -e
#
# Copyright 2016 Osamu Aoki
#
showsig1() {
EXITCODE=$?
SIG=1
echo "SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig2() {
EXITCODE=$?
SIG=3
echo "SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig3() {
EXITCODE=$?
SIG=3
echo "SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig0() {
EXITCODE=$?
SIG=0
echo "SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig4() {
EXITCODE=$?
SIG=4
echo "SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

trap showsig0 0
trap showsig1 1
trap showsig2 2
trap showsig3 3

if [ -n "$1" ]; then
echo "FALSE"
false
fi
echo "============"

while true; do : ; done

# vim:set ai et sw=4 ts=4 tw=80:
