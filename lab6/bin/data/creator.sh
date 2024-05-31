#!/bin/bash

FILES=20

for (( i = 1; i <= FILES; ++i )); do
	./filegen.out 10000000 "file$i"
done

