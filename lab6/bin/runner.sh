#!/bin/bash

run_script="$1" # either run_sequentially.sh or run_concurrently.sh
log_path="$2"

N=20
ATTEMPTS=10

for (( i = 1; i <= N; ++i )); do
	sum=0

	for (( attempt = 1; attempt <= ATTEMPTS; ++attempt )); do
		echo "NOW RUNNING $run_script: N=$i, ATTEMPT=$attempt"
		passed="$( { time ./"$run_script" "$i" ; } 2>&1 | grep real | awk -Fm '{ print $2 }' | head -c -2 )"
		sum="$( echo "$sum + $passed" | bc -l )"
	done

	avg="$( echo "$sum / $ATTEMPTS" | bc -l )"

	printf "%.2f\n" "$avg" >>"$log_path"
	echo "----------"
done

