#!/bin/bash

SIZE_LIMIT="$1"
LAUNCHES="$2"

for (( i = 0; i < LAUNCHES; ++i )); do
	./newmem.sh "$SIZE_LIMIT" &
	sleep 1s
done

