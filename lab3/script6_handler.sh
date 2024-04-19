#!/bin/bash

echo $$ > .pid
x=1

trap '(( x += 2 ))' USR1
trap '(( x *= 2 ))' USR2
trap 'echo "ending calculating. sigterm received" ; exit' SIGTERM

while true; do
	echo $x
	sleep 1
done
