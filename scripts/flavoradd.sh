#!/bin/sh

# flavoradd.sh version 3.2.0/303

old=$(head -n $1 data/score.csv | tail -n 1 | cut -f 3 -d ,)
new=$(($old + 1))

sed -i -E "$1s/^([^,]*),([^,]*),$old$/\\1,\\2,$new/" data/score.csv
