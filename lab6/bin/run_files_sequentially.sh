#!/bin/bash

FILES="$1"

for (( i = 1; i <= FILES; ++i )); do
	./files.out "./data/file$i"
done

