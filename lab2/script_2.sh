#!/bin/bash

info=$(ps aux | tail -n +2 | tr -s " " | cut -d " " -f2,11- --output-delimiter=":")

> script2.out

for elem in $info; do
	pid=$(cut -d: -f1 <<<$elem)
	command=$(cut -d: -f2- --output-delimiter=" " <<<$elem)

	if [[ $command == '/sbin/'* ]]; then
		echo "$pid" >> script2.out

		#to check:
		#echo "$pid $command" >> script2.out
	fi
done
