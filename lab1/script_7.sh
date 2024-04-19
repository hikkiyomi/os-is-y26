#!/bin/bash

emails=$(grep -horIE '\<[[:alnum:]_.]+@[[:alpha:]]+\.[[:alpha:]]+\>' /etc/ 2>/dev/null)
output=""
cnt=0

> emails.lst

for i in $emails; do
	if [[ $cnt -gt 0 ]]; then
		output+=", "
	fi

	(( ++cnt ))
	output+=$i
done

echo "$output" > emails.lst
