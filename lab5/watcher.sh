#!/bin/bash

log_path="$1"
target_process="$2"

> "$log_path"

system_memory() {
	top -bn1 | grep "MiB"
}

mem_script() {
	top -bn1 | grep "$target_process"
}

top_five() {
	top -bn1 | tail -n +8 | head -n 5 | awk '{ print $12 }'
}

analyze() {
	{
		echo "==================="
		echo "$( system_memory )"
		echo ""
		echo "$( mem_script )"
		echo ""
		echo "$( top_five )"
		echo "==================="
		echo ""
	} >> "$log_path"
}

while true; do
	analyze
	sleep 1s
done

