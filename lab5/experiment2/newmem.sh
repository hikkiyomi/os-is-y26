#!/bin/bash

SIZE_LIMIT="$1"

arr=()
iter=0

while true; do
	(( ++iter ))

	arr+=(1 2 3 4 5 6 7 8 9 10)

	if [[ "${#arr[@]}" -gt "$SIZE_LIMIT" ]]; then
		break
	fi
done

