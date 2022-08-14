#!/bin/sh

# tentacle.sh version 3.0.0

export PATH=`pwd`/bin:$PATH
export key=$(cat data/tentacle-key)
export annc=$(cat data/channels/announcements)

while true
do
	scripts/parsemention.sh
	msg $key $annc Collecting eldritch data...
	scripts/unusual.sh | msg $key $annc
done
