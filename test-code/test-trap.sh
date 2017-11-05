#!/bin/sh -e
#
# Copyright 2016 Osamu Aoki
#
# see "kill -l", signal(7)
# +  0 EXIT: on exit
# *  1 HUP:  hang-up (^\)
# *  2 INT:  KB interrupt (^C)
#    3 QUIT: QUIT (^D)
#    7 BUS:  buffer overflow etc.
#   10 USR1: user defined
# * 13 PIPE: broken pipe
# * 15 TERM: trappable termination
# No trap for KILL(9)
showsig0() {
EXITCODE=$?
SIG=0
echo "SIGEXIT SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig1() {
EXITCODE=$?
SIG=1
echo "SIGHUP  SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig2() {
EXITCODE=$?
SIG=3
echo "SIGINT  SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig3() {
EXITCODE=$?
SIG=3
echo "SIGQUIT SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

showsig13() {
EXITCODE=$?
SIG=13
echo "SIGPIPE SIG=$SIG, EXIT=$EXITCODE"
exit $EXITCODE
}

trap showsig0 0
trap showsig1 1
trap showsig2 2
trap showsig3 3
trap showsig7 7

if [ -n "$1" ]; then
echo "FALSE"
false
# -e causes exit
echo "NEVER HERE"
fi
echo "============"

while true; do : ; done

# vim:set ai et sw=4 ts=4 tw=80:
