#!/bin/sh

# rcp-loop.sh version 3.1.0/304

export PATH=`pwd`/bin:$PATH
export key=$(cat data/api-key)
export testchan=$(cat data/channels/testchan)
export rcpchan=$(cat data/channels/rcpchan)
export annc=$(cat data/channels/announcements)
export election=$(cat data/channels/election)
export el="<@&1001702350571974716>"
export mention=mention

## debug overrides:
# export annc=$testchan
# export rcpchan=$testchan
# export el="@Eldritch Legislators"
# export mention=username

export rcp=305

while true
do
	. scripts/sequence.sh
	. scripts/post-sequence.sh
	if [ $(wc -l < scripts/post-sequence.sh) -gt 6 ]
	then
		tail -n +7 scripts/post-sequence.sh >> scripts/sequence.sh
		head -n 6 scripts/post-sequence.sh | sponge scripts/post-sequence.sh
	fi
done
