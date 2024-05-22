#!/bin/bash

lines=$( ps ax -o pid,command --no-headers )

while read line; do
	pid=$( echo "$line" | awk '{ print $1 }' )

	if ! [ -d "/proc/$pid" ]; then
		continue
	fi

	cmd=$( echo "$line" | awk '{ for (i = 2; i < NF; i++) printf $i " "; print $NF }' )
	bytes=$( grep read_bytes /proc/$pid/io | awk '{ print $2 }' )

	echo "$pid#$cmd#$bytes"
done > tmp7 <<<"$lines"

sleep 10s

lines=$( ps ax -o pid,command --no-headers )

while read line; do
	pid=$( echo "$line" | awk '{ print $1 }' )

	if ! [ -d "/proc/$pid" ]; then
		continue
	fi

	cmd=$( echo "$line" | awk '{ for (i = 2; i < NF; i++) printf $i " "; print $NF }' )
	grep_result=$( grep -e "^$pid#" tmp7 )
	read_bytes=$( grep read_bytes /proc/$pid/io | awk '{ print $2 }' )
	
	if [[ -n "$grep_result" ]]; then
		prev_read_bytes=$( echo "$grep_result" | awk -F '#' '{ print $3 }' )
		difference=$( echo "$read_bytes $prev_read_bytes" | awk '{ print ($1 - $2) }' )
		echo "$pid#$cmd#$difference"
	else
		echo "$pid#$cmd#$read_bytes"
	fi
done <<<"$lines" | sort -nrt '#' -k3 | head -n3 | tr '#' ':'
