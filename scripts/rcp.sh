#!/bin/sh

# rcp.sh version 3.0.0

while true
do
	rcp $key $1 | while read line
	do
		case $line in
			y)
				if [ $rcp -le $((300 + 2 * $(wc -l < data/players))) ]
				then
					[ "$(
						count $key $1 $2 y
					)" -eq "$(
						wc -l < data/players
					)" ] && msg $key $annc "$el all players have voted.  The poll will close in 15 minutes unless a vote is removed." > /dev/null
					if scripts/close-rcp.sh $1 $2
					then
						finished=true
					fi
				elif [ "$(($(
					count $key $1 $2 y
				) + $(
					count $key $1 $2 n
				)))" -eq $(
					wc -l < data/players
				) ]]
				then
					 msg $key $annc "$el all players have voted.  The poll will close in 15 minutes unless a vote is removed." > /dev/null
					if scripts/close-rcp.sh $1 $2
					then
						finished=true
					fi
				fi
					
			;;
			n)
				if [ $rcp -le $((300 + 2 * $(wc -l < data/players))) ]
				then
					msg $key $annc "$el there has been a 'no' vote.  Since this is a unanimous poll, it will close in 15 minutes unless the 'no' vote is removed." > /dev/null
					if scripts/close-rcp.sh $1 $2
					then
						finished=true
					fi
				elif [ "$(($(
					count $key $1 $2 y
				) + $(
					count $key $1 $2 n
				)))" -eq $(
					wc -l < data/players
				) ]
				then
					 msg $key $annc "$el all players have voted.  The poll will close in 15 minutes unless a vote is removed." > /dev/null
					if scripts/close-rcp.sh $1 $2
					then
						finished=true
					fi
				fi
			;;
		esac
		$finished && break
	done
	$finished && break
	cp data/players data/nonvoters
	for voter in "$( {
		identify-voters $1 $2 y
		identify-voters $1 $2 n
	} | tr '\n' ' ')"
	do
		grep -v $voter data/nonvoters | sponge data/nonvoters
	done
	msg=""
	for player in "$(tr '\n' ' ' < data/nonvoters)"
	do
		msg="$msg$($mention $key player), "
	done
	msg $key $annc "${msg}this is your 48-hour reminder that it is time to vote on RCP $rcp." > /dev/null
done
