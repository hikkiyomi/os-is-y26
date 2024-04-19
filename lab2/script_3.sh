#!/bin/bash

info=$(ps aux | tail -n +2 | tr -s " " | cut -d " " -f2,9 --output-delimiter="#")
max_timestamp=-1
ans_pid=-1

for elem in $info; do
	pid=$(cut -d "#" -f1 <<<$elem)
	hhmm=$(cut -d "#" -f2 <<<$elem)
	hours=$(cut -d ":" -f1 <<<$hhmm)
	minutes=$(cut -d ":" -f2 <<<$hhmm)
	timestamp=$(( $hours * 60 + $minutes ))

	if [[ $max_timestamp -lt $timestamp ]]; then
		max_timestamp=$timestamp
		ans_pid=$pid
	fi
done

echo $pid
