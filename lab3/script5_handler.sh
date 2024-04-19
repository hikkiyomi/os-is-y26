#!/bin/bash

mode="+"
x=1

get_tail_pid() {
	ps axo pid,ppid,comm --no-headers | awk -v pid=$1 '{ if ($2 == pid && $3 == "tail") print $1 }'
}

set -f

(tail -f pipe5) |
while true; do
	read LINE

	if [[ $LINE == "QUIT" ]]; then
		echo "exited"
		kill -kill $( get_tail_pid $$ )
		exit
	elif [[ $LINE == "+" ]]; then
		mode="+"
	elif [[ $LINE == '*' ]]; then
		mode='*'
	elif [[ $LINE =~ ^-?[0-9]+$ ]]; then
		if [[ $mode == "+" ]]; then
			(( x += LINE ))
		else
			(( x *= LINE ))
		fi

		echo $x
	else
		set +f
		echo "wrong input!" >&2
		killall script5_generator.sh
		rm -f tmp_file5
		exit 1
	fi
done

