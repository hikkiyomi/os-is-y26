#!/bin/bash

rm -f pipe5
mkfifo pipe5

set -f

while true; do
	read LINE
	echo $LINE > pipe5

	if [[ $LINE == "QUIT" ]]; then
		set +f
		exit
	fi	
done
