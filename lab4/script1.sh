#!/bin/bash

get_number() {
	last=$( cd $HOME/.trash && find . -type f \
		| tail -c +3 \
		| sort -rn \
		| head -n1 )

	if [ -z "$last" ]; then
		last=0
	fi

	printf "%d" "$(( last + 1 ))"
}

if [[ $# -ne 1 ]]; then
	echo "Exactly one parameter should be passed to the script." >&2
	exit 1
fi

if [[ -d $1 ]]; then
	echo "Cannot put directories in trash. $1 is a directory." >&2
	exit 1
fi

if ! [[ -f $1 ]]; then
	echo "No such file as $1 in the current directory." >&2
	exit 1
fi

mkdir -p $HOME/.trash

filepath="$PWD/$1"
number=$( get_number )

ln -- "$filepath" $HOME/.trash/$number && rm -f -- "$filepath"
echo "$filepath/$number" >> $HOME/.trash.log

