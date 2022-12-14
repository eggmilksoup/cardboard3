#!/bin/sh

# await-rcp.sh version 3.1.0

msg $key $annc "It is time to start talking about RCP $rcp, which is being proposed by $(
	$mention $key $(
		head -n $((($rcp - 300) % $(
			wc -l < data/players
		))) data/players | tail -n 1
	)
).  You will receive a reminder in 48 hours to post this RCP." > /dev/null

[ -f data/sent ] && rm data/sent
while true
do
	logdms $key $(
		head -n 1 data/players             # skylar
	) $(
		head -n 4 data/players | tail -n 1 # egg
	) $(
		tail -n 1 data/players             # david
	) | while read line
	do
		case "$(printf "$line" | cut -f 3 -d : | cut -f 1-2 -d " ")" in
			"begin rcp")
				printf "$line" | cut -f 3- -d ' ' > data/title
				if ! [ -n "$(cat data/title)" ]
				then
					msg $key $(printf "$line" | cut -f 1 -d :) "Your RCP needs a title. Say \"begin rcp <title>\" to begin an rcp." > /dev/null
				else
					[ -f data/rcp ] && rm data/rcp
					reading=true
					msg $key $(printf "$line" | cut -f 1 -d :) "recording rcp" > /dev/null
					while $reading && read line
					do
						case "$(printf "$line" | cut -f 3 -d :)" in
							"end rcp")
								reading=false
								msg $key $(
									printf "$line" | cut -f 1 -d :
								) "done recording. Say \"send rcp\" to send." > /dev/null
							;;
							*)
								printf "$line" | cut -f 2 -d : >> data/rcp
							;;
						esac
					done
				fi
			;;
			"send rcp")
				if [ -f data/rcp ]
				then
					thread=$(
						mkthread $key $rcpchan "RCP $(
							cat data/title
						)" $((7 * 24 * 60))
					)
					msg=$(
						formatrcp  "$(
							cat data/title
						)" "$(
							pullrcp $key $(
								printf "$line" | cut -f 1 -d :
							) $(
								tr '\n' ' ' < data/rcp
							)
						)" | msg $key $thread
					)
					echo $thread $msg
					touch data/sent
					break
				fi
				msg $key $(
					printf "$line" | cut -f 1 -d :
				) "You haven't composed an rcp!" > /dev/null
			;;
		esac
	done
	[ -f data/sent ] && break
	msg $key $annc "$(
		$mention $key $(
			head -n $((($rcp - 300) % $(
				wc -l < data/players
			))) data/players | tail -n 1
		)
	), this is your 48-hour reminder that it's your turn to propose RCP $rcp." > /dev/null
done
