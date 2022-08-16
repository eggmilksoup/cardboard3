#!/bin/sh

# playervote.sh version 3.1.0/303

while true
do
	emojicat $key $2 | while read emoji
	do
		finished=false
		if grep -q $emoji data/emoji
		then
			n=$(countemoji $key $1 $2 $emoji)
			if [ $n -gt $(($(wc -l < data/players) / 2)) ]
			then
				player="$(
					$mention $key $(
						head -n $(
							grep -n data/emoji $emoji |
								cut -f 1 -d :
						) data/players |
							tail -n 1
					)
				)"
				msg $key $annc "$el, $player has received the necessary votes to win.  The poll will close in 15 minutes unless a vote for $player is retracted."
				if scripts/playerclose.sh $1 $2
				then
					finished=true
				fi
			else
				n=0
				for e in $(tr '\n' ' ' < /data/emoji)
				do
					n=$(($n + $(countemoji $key $1 $2 $emoji)))
				done
				[ $n -eq $(wc -l < data/players) ] && if scripts/playerclose.sh
				then
					msg $key $annc "$el, everybody has voted, but nobody received enough votes to win the election.  The player(s) with the least votes will be rolled off and another vote will take place in 15 minutes unless a vote is retracted."
					if scripts/favclose.sh $1 $2
					then
						finished=true
					fi
				fi
			fi
		fi
	$finished && break
	done
	out=""
	cp data/players data/nonvoters
	for player in $(
		for i in $(seq 10 | tr '\n' ' ')
		do
			identify-voters $key $1 $2 $i
		done | tr '\n' ' '
	)
	do
		grep -v $player data/nonvoters | sponge data/nonvoters
	done
	for player in $(tr '\n' ' ' < data/nonvoters)
	do
		out="$out$($mention $key $player), "
	done
	msg $key $annc "${out}this is your 48-hour reminder that it's time to vote for $3."
done
