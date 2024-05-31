#!/bin/bash

amount="$1"

BASE=300000000
INCREASE=1000

for (( iter = 0; iter < amount; ++iter )); do
	N="$(( BASE + INCREASE * iter ))"
	./calc.out "$N" 1>/dev/null
done

