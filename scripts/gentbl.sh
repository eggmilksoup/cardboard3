#!/bin/sh

# gentbl.sh version 3.2.0/303

max=$(printf "Player" | wc -c)
while read line
do
	name="$(printf "$line" | cut -f 1 -d ,)"
	chars=$(printf "$name" | wc -c)
	if [ $chars -gt $max ]
	then
		max=$chars
	fi
done < data/score.csv

printf "| Player"

for i in $(seq $(($max - $(printf "Player" | wc -c))) | tr '\n' ' ')
do
	printf ' '
done

echo " | Points | Political Flavor |"

printf '|-'
for i in $(seq $max | tr '\n' ' ')
do
	printf '-'
done

echo "-+--------+------------------|"

while read line
do
	name="$(printf "$line" | cut -f 1 -d ,)"
	chars=$(printf "$name" | wc -c)
	printf "| $name"
	if [ $chars -ne $max ]
	then
		for i in $(seq $(($max - $chars)) | tr '\n' ' ')
		do
			printf ' '
		done
	fi
	printf " | "
	points=$(printf "$line" | cut -f 2 -d ,)
	chars=$(printf "$points" | wc -c)
	if [ $chars -ne 6 ]
	then
		for i in $(seq $((6 - $chars)) | tr '\n' ' ')
		do
			printf ' '
		done
	fi
	printf "$points | "
	flavor=$(printf "$line" | cut -f 3 -d ,)
	chars=$(printf "$flavor" | wc -c)
	if [ $chars -ne 16 ]
	then
		for i in $(seq $((16 - $chars)) | tr '\n' ' ')
		do
			printf ' '
		done
	fi
	echo "$flavor |"
done < data/score.csv
