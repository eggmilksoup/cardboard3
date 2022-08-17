#!/bin/sh

# scoreadd.sh version 3.2.0/303

old=$(head -n $1 data/score.csv | tail -n 1 | cut -f 2 -d ,)
new=$(($old + $2))

sed -i -E "$1s/^([^,]*),$old,([^,]*)$/\\1,$new,\\2/" data/score.csv
