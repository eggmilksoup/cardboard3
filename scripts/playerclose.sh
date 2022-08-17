#!/bin/sh

# playerclose.sh version 3.2.0/303

status $key "Polls closing soon!"

tot=0
min=$(wc -l < data/players)
for emoji in $(tr '\n' ' ' < data/emoji)
do
	n=$(countemoji $key $1 $2 $emoji)
	if [ $n -gt $(($(wc -l < data/players) / 2)) ]
	then
		playerno=$(grep -n $emoji data/emoji | cut -f 1 -d :)
		msg $key $annc "$el, $(
			$mention $key $(head -n $playerno data/players)
		) has won the vote, and $(
			case "$3" in
				("political")
					scripts/flavoradd.sh $playerno
					echo "has received one political flavor."
				;;
				# ("secretkeeper")
				# 	echo "has been elected secretkeeper."
				# ;;
			esac
		)"
		break
	fi
	[ $n -eq 0 ] && continue

	tot=$(($tot + $n))
	if [ $n -lt $min ]
	then
		min=$n
		keep="$keep $rolloff"
		rolloff=$emoji
	elif [ $n -eq $min ]
	then
		rolloff="$rolloff $emoji"
	else
		keep="$keep $emoji"
	fi
done
for emoji in $rolloff
do
	romention="$romention$(
		$mention $key $(
			head -n $(
				grep -n $emoji data/emoji |
					cut -f 1 -d :
			) data/players | tail -n 1
		)
	) "
done
scripts/playervote.sh $1 $(
	msg $key $annc <<EOF
**Official Vote Thread**
The following players have been rolled off for having the least positive number of votes and are no longer valid candidates:
$romention
The following players remain as valid candidates for $3 $4:
$(
	for emoji in $keep
	do
		$mention $key $(
			head -n $(
				grep -n $emoji data/emoji |
					cut -f 1 -d :
			) data/players | tail -n 1
		) | sed 's/^/	/' | tr -d '\n'
		echo : $emoji
	done
)
React to this message with one of the above emoji to vote for a player besides yourself.
Remember that you may not vote for yourself or any player that has been rolled off.
EOF
) $3 $4
