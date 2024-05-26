#!/bin/bash

watcher_log="$1"
parse_path="./parsed/$watcher_log"

mkdir -p "$parse_path"

( grep "MiB" "$watcher_log" \
	| awk -F 'free' '{ print $1 }' \
	| awk -F ',' '{ print $2 }' \
	| tr -d ' ' ) > "$parse_path/memory_swap_free"

( grep "MiB" "$watcher_log" \
	| awk -F 'used' '{ print $1 }' \
	| awk -F ',' '{ print $3 }' \
	| tr -d ' ' ) > "$parse_path/memory_swap_used"

( grep "root" "$watcher_log" \
	| awk '{ print $5 }' ) > "$parse_path/virtual_memory_used"

( grep "root" "$watcher_log" \
	| awk '{ print $10 }' ) > "$parse_path/memory_usage_percent"

