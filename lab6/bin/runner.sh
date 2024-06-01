#!/bin/bash

run_script="$1"
log_path="$2"
create_files="$3"

create_file() {
	path="./data/file$1"
	rm -f "$path"
	./data/filegen.out 7500000 "$path"
}

N=20
ATTEMPTS=10

for (( i = 1; i <= N; ++i )); do
	sum=0

	for (( attempt = 1; attempt <= ATTEMPTS; ++attempt )); do
		if [[ "$create_files" = "yes" ]]; then
			for (( j = 1; j <= i; ++j )); do
				create_file "$j"
			done
		fi

		echo "NOW RUNNING $run_script: N=$i, ATTEMPT=$attempt"

		time_before="$( date +%s.%3N )"

		./"$run_script" "$i"

		time_after="$( date +%s.%3N )"
		passed="$( echo "$time_after - $time_before" | bc -l )"
		sum="$( echo "$sum + $passed" | bc -l )"

		echo "FINISHED. PASSED $passed SECONDS"
		echo ""
	done

	avg="$( echo "$sum / $ATTEMPTS" | bc -l )"

	printf "%.2f\n" "$avg" >>"$log_path"
	echo "----------"
done

