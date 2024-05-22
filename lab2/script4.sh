#!/bin/bash

> output4

for pid in $( ps axo pid --no-headers ); do
	if ! [ -d "/proc/$pid" ]; then
		continue
	fi

	sched_path="/proc/$pid/sched"
	status_path="/proc/$pid/status"
	
	ppid=$( cat $status_path | grep PPid | awk '{ print $2 }' )
	sum_exec_runtime=$( cat $sched_path | grep sum_exec_runtime | awk '{ print $3 }' )
	nr_switches=$( cat $sched_path | grep nr_switches | awk '{ print $3 }' )
	
	art=$( echo "$sum_exec_runtime $nr_switches" | awk '{ printf "%f", $1 / $2}' )
	
	echo "$pid $ppid $art"
done | sort -n -k2 | awk '{ print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3 }' > output4
