#!/bin/bash

FILES="$1"

for (( i = 1; i <= FILES; ++i )); do
	datafile="./data/file$i"
	./files.out "$datafile" &
done

while true; do
	if ! top -bn 1 | grep -q files.out; then
		break
	fi
done

