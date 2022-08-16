#!/bin/sh

# sequence.sh version 3.1.0

while [ $((($rcp - 300) % $(wc -l < data/players))) -gt 0 ]
do
	scripts/rcp.sh $(scripts/await-rcp.sh)
	
	# Create a scripts/post-rcp.sh file for one-time post-rcp events.
	[ -f scripts/post-rcp.sh ] && {
		. scripts/post-rcp.sh
		mv scripts/post-rcp.sh scripts/archive/post-$rcp.sh
	}
	export rcp=$(($rcp + 1))
done

# this last one represents the final rcp before the next circuit
scripts/rcp.sh $(scripts/await-rcp.sh)

[ -f scripts/post-rcp.sh ] && {
	. scripts/post-rcp.sh
	mv scripts/post-rcp.sh scripts/archive/post-$rcp.sh
}
export rcp=$(($rcp + 1))

# post-circuit events, such as eldritch assembly, political flavor voting, etc.
. scripts/end-circuit.sh
