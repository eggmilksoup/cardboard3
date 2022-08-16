#!/bin/sh

# close-rcp.sh version 3.1.0

status $key "polls closing soon!"
if [ $rcp -le $((300 + $(wc -l < data/players) * 2)) ]
then
	if [ $(count $key $1 $2 y) -eq $(wc -l < data/players) ]
	then
		msg $key $annc <<EOF
$el, the vote for RCP $rcp has passed.
$($mention $key $(
	head -n $((($rcp - 300) % $(
		wc -l < data/players
	))) data/players | tail -n 1
)) has gained $(($rcp - 291)) points.
All players voted yes.
EOF
	elif [ $(count $key $1 $2 n) -gt 0 ]
	then
		msg $key $annc <<EOF
$el, the vote for RCP $rcp has failed to pass.
$($mention $key $(
	head -n $((($rcp - 300) % $(
		wc -l < data/players
	))) data/players | tail -n 1
)) has lost 10 points.
The following players voted no:
$(
	for voter in $(identify-voters $key $1 $2 n | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
EOF
	else
		msg $key $annc "$el The end of the vote has been cancelled; votes were retracted."
		false
	fi
else
	yes=$(count $key $1 $2 y)
	no=$(count $key $1 $2 n)
	if [ $(($yes + $no)) -eq $(wc -l < data/players) ]
	then
		if [ $yes -gt $no ]
		then
			msg $key $annc <<EOF
$el, the vote for RCP $rcp has passed.
$($mention $key $(
	head -n $((($rcp - 300) % $(
		wc -l < data/players
	))) data/players | tail -n 1
)) has gained $((($rcp - 291) * $yes / $no)) points.
The following players voted yes:
$(
	for voter in $(identify-voters $key $1 $2 y | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
The following players voted no:
$(
	for voter in $(identify-voters $key $1 $2 n | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
The players who voted no have received 10 points each.
EOF
		elif [ $no -gt $yes ]
		then
			msg $key $annc <<EOF
$el, the vote for RCP $rcp has failed to pass.
$($mention $key $(
	head -n $((($rcp - 300) % $(
		wc -l < data/players
	))) data/players | tail -n 1
)) has lost 10 points.
The following players voted yes:
$(
	for voter in $(identify-voters $key $1 $2 y | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
The following players voted no:
$(
	for voter in $(identify-voters $key $1 $2 n | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
EOF
		else
			msg $key $annc "$el the vote has tied.  Since there is no precedent or rule that governs how to proceed, this must be discussed among you before you can continue."
			false
		fi
	else
		msg $key $annc "$el The end of the vote has been cancelled; votes were retracted."
		false
	fi
fi
