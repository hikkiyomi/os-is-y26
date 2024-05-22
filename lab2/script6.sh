#!/bin/bash

max_resident=-1
answer_pid=-1

for pid in $( ps axo pid --no-headers ); do
	if ! [ -d "/proc/$pid" ]; then
		continue
	fi

	resident=$( cat /proc/$pid/statm | awk '{ print $2 }' )	
	
	if [[ $max_resident -lt $resident ]]; then
		max_resident=$resident
		answer_pid=$pid
	fi
done

echo "script: $answer_pid"
echo "top: $( top -n1 -bo +%MEM | tail -n +8 | head -n1 | awk '{ print $1 }' )"
