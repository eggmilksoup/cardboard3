#!/bin/sh

# findrule.sh version 3.0.0

top=$(grep -n "^\\*\\* Rule $1" /var/git/tns-nomic.git/da-rules.org |
	cut -f 1 -d : |
	tr  -d '\n')

bot=$(tail -n +$(($top + 1)) /var/git/tns-nomic.git/da-rules.org |
	grep -n '\*\* Rule' |
	cut -f 1 -d : |
	head -n 1 |
	tr -d '\n')

tail -n +$top /var/git/tns-nomic.git/da-rules.org |
	head -n $bot |
	sed 's/^\*/\
\*/g' |
	sed 's/\*/\\\*/g' |
	sed 's/  / /' | 
	tr '\n' ' ' |
	sed 's/  /\
\
/g'
