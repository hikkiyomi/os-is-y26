#!/bin/bash

prev_ppid=-1
sum=0
cnt=1

printInfo() {
	if [[ $prev_ppid -ne -1 ]]; then
		echo "$prev_ppid $sum $cnt" | awk '{ printf "Average_Running_Children_of_ParentID=%d is %f\n", $1, $2 / $3 }'
	fi
}

lines=$( cat output4 )

while read line; do
	ppid=$( echo $line | awk -F ' : ' '{ print $2 }' | awk -F= '{ print $2 }' )
	art=$( echo $line | awk -F ' : ' '{ print $3 }' | awk -F= '{ print $2 }' )
	
	if [[ $ppid -eq $prev_ppid ]]; then
		sum=$( echo "$sum $art" | awk '{ printf "%f", $1 + $2 }' )
		(( ++cnt ))
	else
		printInfo
		sum=$art
		cnt=1
	fi

	prev_ppid=$ppid

	echo $line
done > output5 <<< "$lines"

printInfo >> output5
