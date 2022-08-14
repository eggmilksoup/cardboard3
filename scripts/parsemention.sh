#!/bin/sh
logmentions | while read line
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
					sed 's/  / /' < 
						/var/git/tns-nomic-records/rcp/$word |
						tr '\n' ' ' |
						sed 's/  /\n\n/' |
						msg $key $testchan &&
						continue
					msg $key $annc no such rcp \"$word\"
				elif $rule
					if [ $word = list ]
					then
						scripts/rulelist.sh | msg $key $testchan
						rule=false
					fi
					scripts/findrule.sh $word | msg $key $testchan && continue
					msg $key $annc no such rule \"$word\"
				fi
			;;
		esac
	done
done
