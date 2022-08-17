#!/bin/sh

# genrecords.sh version 3.2.0

echo '* Scoreboard'
echo

scripts/gentbl.sh

echo
echo '* Legislative Actions'

cat data/legacts.org
