#!/bin/bash

info=$(ps aux | tail -n +2 | tr -s " " | cut -d " " -f1,2,11- --output-delimiter=":")
count=0
output=""

> script1.out

for elem in $info; do
	user=$(cut -d: -f1 <<<$elem)
	pid=$(cut -d: -f2 <<<$elem)
	command=$(cut -d: -f3- --output-delimiter=" " <<<$elem)

	if [[ $user == "user" ]]; then
		(( ++count ))

		if [[ "$count" -gt 1 ]]; then
			output+=$'\n'
		fi

		output+="$pid:$command"
	fi
done

echo "$count" >> script1.out
echo "$output" >> script1.out
