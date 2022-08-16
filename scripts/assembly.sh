#!/bin/sh

# assembly.sh version 3.1.0/302

msg $key $annc "$el, it is time to schedule the Eldritch Assembly."

finished=false
while ! $finished
do
	logdms $key $(
		head -n 1 data/players             # skylar
	) $(
		head -n 4 data/players | tail -n 1 # egg
	) $(
		tail -n 1 data/players             # david
	) | while read line
	do
		case "$(printf "$line" | cut -f 3 -d : | cut -f 1 -d ' ')" in
			"assembly")
				assembly=$(printf "$line" | cut -f 2 -d ' ')
				msg $key $(
					printf "$line" | cut -f 1 -d :
				) "assembly scheduled for $assembly days from now."
			;;
		esac
	done
	case $assembly in
		0)
			msg $key $annc "$el, this is your 48-hour reminder that today is Eldritch Assembly day."
			finished=true
		;;
		1)
			msg $key $annc "$el, this is your 48-hour reminder that tomorrow is Eldritch Assembly day."
			finished=true
		;;
		1*|2*|3*|4*|5*|6*|7*|8*|9*)
			msg $key $annc "$el, this is your 48-hour reminder that the Eldritch Assembly is in $assembly days."
			assembly=$(($assembly - 2))
		;;
		*)
			msg $key $annc "$el, this is your 48-hour reminder to schedule the Eldritch Assembly."
		;;
	esac
done
sleep $((48 * 60 * 60))
