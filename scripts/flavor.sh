#!/bin/sh

# flavor.sh version 3.1.0/303

msg $key $annc "It is time to vote for political flavor."

thread=$(mkthread $key $election "Political Flavor $((($rcp - 300) / 10 + 1))" $((7 * 24 * 60)))

scripts/playervote.sh $thread $(
	msg $key $thread <<EOF
**Official Vote Thread**
React to this message with the following emoji to vote for a player besides yourself:
$(
	for i in $(seq $(wc -l < data/players) | tr '\n' ' ')
	do
		echo "$(
			$mention $key $(
				head -n $i data/players | tail -n 1
			)
		): $(
			head -n $i data/emoji | tail -n 1
		)"
	done
)
The player who wins this vote will gain one Political Flavor.
Remember that you may not vote for yourself.
EOF
) "political flavor"
