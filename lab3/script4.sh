#!/bin/bash

launch() {
	x=1

	while true; do
		(( x *= 1 ))
	done
}

fix_nice() {
	while true; do
		usage=$( top -bn1 -p $1 | tail -n +8 | awk '{ print $9 }' )
		usage=${usage%.*}

		nicety=$( top -bn1 -p $1 | tail -n +8 | awk '{ print $4 }' )
		
		if [[ $usage -gt 10 ]] && [[ $nicety -lt 19 ]]; then
			echo "usage is $usage... renicing"
			echo "nicety is $nicety... incrementing nicety"
			(( nicety++ ))
			renice -n $nicety -p $1
		fi
	done
}

pid1=0
pid2=0
pid3=0
fixer=0

launch & pid1=$!
launch & pid2=$!
launch & pid3=$!
fix_nice $pid1 & fixer=$!

echo "$pid1 $pid2 $pid3"
echo "$fixer"

kill $pid3
