#!/bin/bash

set -f

while true; do
	read LINE

	case $LINE in
		"+")
			kill -USR1 $( cat .pid )
			;;
		"*")
			kill -USR2 $( cat .pid )
			;;
		"TERM")
			kill -SIGTERM $( cat .pid )
			break
			;;
		*)
			;;
	esac
done

set +f
