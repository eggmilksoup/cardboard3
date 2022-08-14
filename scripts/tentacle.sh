#!/bin/sh

# tentacle.sh version 3.0.0

export PATH=`pwd`/bin:$PATH
export key=$(cat data/tentacle-key)
export agora=$(cat data/channels/agora)

while true
do
	msg $key $agora Collecting eldritch data...
	scripts/unusual.sh | msg $key $agora
	scripts/parsemention.sh
done
