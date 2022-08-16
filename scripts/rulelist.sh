#!/bin/sh

# rulelist.sh version 3.0.0

grep -E '^\*\*? ' /var/git/tns-nomic.git/da-rules.org | sed 's/\*/\\\*/g'
