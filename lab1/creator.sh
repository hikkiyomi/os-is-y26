#!/bin/bash

tasks=10

for (( i = 1; i <= tasks; ++i ))
do
	touch "script_$i.sh"
	chmod u+x "script_$i.sh"
done

