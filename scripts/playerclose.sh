#!/bin/sh

# playerclose.sh version 3.1.0/303

status $key "Polls closing soon!"

tot=0
min=$(wc -l < data/players)
for emoji in $(tr '\n' ' ' < data/players)
do
	n=$(countemoji $key $1 $2 $emoji)
	if [ $n -gt $(($(wc -l < data/players) / 2)) ]
	then
		msg $key $annc "$el, $(
			$mention $key $(
				head -n $(
					grep -n $emoji data/emoji |
						cut -f 1 -d :
				) data/players
			)
		) has won the vote, and $(
			case "$3" in
				("political flavor")
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
			) data/players
		)
	) "
done
for emoji in $keep
do
	keepmention="$keepmention
	$(
		$mention $key $(
			head -n $(
				grep -n $emoji data/emoji |
					cut -f 1 -d :
			) data/players
		)
	): $emoji"
done
scripts/playervote.sh $flavchan $(
	msg $key $annc <<EOF
**Official Vote Thread**
The following players have been rolled off for having the least positive number of votes and are no longer valid candidates:
$romention
The following players remain as valid candidates for $3:
$keepmention
React to this message with one of the above emoji to vote for a player besides yourself.
Remember that you may not vote for yourself or any player that has been rolled off.
EOF
) "$3"
