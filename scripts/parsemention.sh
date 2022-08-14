#!/bin/sh
logmentions $key | while read line
do
	rule=false
	rcp=false
	for word in $(printf "$line" | cut -f 3 -d :)
	do
		case $word in 
			rcp)
				rule=false
				rcp=true
			;;
			rule)
				rcp=false
				rule=true
			;;
			*)
				if $rcp
				then
					sed 's/  / /' /var/git/tns-nomic-records/rcp/$word |
						tr '\n' ' ' |
						sed 's/  /\n\n/' |
						msg $key $agora &&
						continue
					msg $key $(printf $line | cut -f 1 -d :) no such rcp \"$word\"
				elif $rule
				then
					if [ $word = list ]
					then
						scripts/rulelist.sh | msg $key $(printf $line | cut -f 1 -d :)
						rule=false
					fi
					scripts/findrule.sh $word |
						msg $key $(printf $line | cut -f 1 -d :) &&
						continue
					msg $key $(printf $line | cut -f 1 -d :) no such rule \"$word\"
				fi
			;;
		esac
	done
done
