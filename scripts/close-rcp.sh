#!/bin/sh

# close-rcp.sh version 3.1.0

status $key "polls closing soon!"

playerno=$((($rcp - 300) % $(
	wc -l < data/players
)))
points=$(($rcp - 291))

if [ $rcp -le $((300 + $(wc -l < data/players) * 2)) ]
then
	yes=$(count $key $1 $2 y)
	if [ $yes -eq $(wc -l < data/players) ]
	then
		scripts/scoreadd.sh $playerno $points
		msg $key $annc <<EOF
$el, the vote for RCP $rcp has passed.
$($mention $key $(
	head -n $playerno data/players |
		tail -n 1
)) has gained $points points.
All players voted yes.
EOF
		cat >> data/legacts.org <<EOF

** RCP $rcp Adopted
on $(date +%Y-%m-%d), [[file:rcp/$rcp][RCP $rcp]], by $(head -n $playerno data/score.csv |
	tail -n 1 |
	cut -f 1 -d ,
), was adopted by a unanimous vote ($yes:0).
EOF
		scripts/update-website.sh "RCP $rcp passed"
		(
			cd /var/git/tns-nomic.git/
			patch -sp1 -i ~/src/cardboard3/patches/$rcp.diff
			git add da-rules.org
			git commit -m "RCP $rcp passed"
			git push
			../org2html/org2html < da-rules.org > /var/www/htdocs/nomic/rules.html
		)
	else
		no=$(count $key $1 $2 n)
		if [ $no -gt 0 ]
		then
			scripts/scoreadd.sh $playerno -10
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
			cat >> data/legacts.org <<EOF

** RCP $rcp Rejeceted
on $(date +%Y-%m-%d), [[file:rcp/$rcp][RCP $rcp]], by $(head -n $playerno data/score.csv |
	tail -n 1 |
	cut -f 1 -d ,
), was rejected by non-unanimous vote ($yes:$no).
EOF
			scripts/update-website.sh "RCP $rcp failed"
		else
			msg $key $annc "$el The end of the vote has been cancelled; votes were retracted."
			false
		fi
	fi
else
	yes=$(count $key $1 $2 y)
	no=$(count $key $1 $2 n)
	if [ $(($yes + $no)) -eq $(wc -l < data/players) ]
	then
		if [ $yes -gt $no ]
		then
			yespoints=$(($points * $yes / $no))
			novoters="$(identify-voters $key $1 $2 n | tr '\n' ' ')"
			scripts/scoreadd.sh $playerno $yespoints
			for voter in $novoters
			do
				scripts/scoreadd.sh $(
					grep -n $voter data/players |
						cut -f 1 -d :
				) 10
			done
			msg $key $annc <<EOF
$el, the vote for RCP $rcp has passed.
$($mention $key $(
	head -n $playerno data/players | tail -n 1
)) has gained $yespoints points.
The following players voted yes:
$(
	for voter in $(identify-voters $key $1 $2 y | tr '\n' ' ')
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
The following players voted no:
$(
	for voter in $novoters
	do
		$mention $key $voter
	done | sed 's/^/	/'
)
The players who voted no have received 10 points each.
EOF
			cat >> data/legacts.org <<EOF

** RCP $rcp Adopted
on $(date +%Y-%m-%d), [[file:rcp/$rcp][RCP $rcp]], by $(head -n $playerno data/score.csv |
	tail -n 1 |
	cut -f 1 -d ,
), was adopted by a majority vote ($yes:$no).
EOF
			scripts/update-website.sh "RCP $rcp passed"
			(
				cd /var/git/tns-nomic.git/
				patch -sp1 -i ~/src/cardboard3/patches/$rcp.diff
				git add da-rules.org
				git commit -m "RCP $rcp passed"
				git push
				../org2html/org2html < da-rules.org > /var/www/htdocs/nomic/rules.html
			)
		elif [ $no -gt $yes ]
		then
			scripts/addscore.sh $playerno -10
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
			cat >> data/legacts.org <<EOF

** RCP $rcp Rejeceted
on $(date +%Y-%m-%d), [[file:rcp/$rcp][RCP $rcp]], by $(head -n $playerno data/score.csv |
	tail -n 1 |
	cut -f 1 -d ,
), was rejected by a majority vote ($yes:$no).
EOF
			scripts/update-website.sh "RCP $rcp failed"
		else
			msg $key $annc "$el the vote has tied.  Since there is no precedent or rule that governs how to proceed, this must be discussed among you before you can continue."
			false
		fi
	else
		msg $key $annc "$el The end of the vote has been cancelled; votes were retracted."
		false
	fi
fi
