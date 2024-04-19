#!/bin/bash

files=$(find /var/log/ -name '*.log' 2>/dev/null)
wc -l $files | tail -n1 | cut -d ' ' -f3

#count=0

#for file in $files; do
#	(( count+="$(wc -l $file | cut -d ' ' -f1)" ))
#done

#echo $count
