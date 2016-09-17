#!/bin/sh
# list all ratpoison commands
# Magnus japh Woldrich
# 2016-09-17 14:00:42
grep RP_CMD ${HOME}/dev/catpoison/src/actions.h | \
  awk '{print $2}'                              | \
  perl -pe 's/\((\w+)\);/$1/'                   | \
  sort -u
