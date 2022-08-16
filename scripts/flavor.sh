#!/bin/sh

# flavor.sh version 3.1.0/303

flavchan=$testchan

msg $key $annc "It is time to vote for political flavor."

scripts/playervote.sh $flavchan $(
	msg $key $flavchan <<EOF
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
