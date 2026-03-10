#!/bin/bash
# create gdbinit address variables

cat $1 | sed -e 's@,@@g'  -e 's@ @@g' -e 's@\t@@g' | egrep -v ^$ | sed -e 's@=@ @g' | sort | awk '{ print "set $"$1" = "$2}'