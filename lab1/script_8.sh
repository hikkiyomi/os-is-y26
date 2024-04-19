#!/bin/bash

awk -F: '{ print $1"	"$3 }' /etc/passwd | sort -n -k2

# can also be done with this one:
# cut -d: -f1,3 /etc/passwd --output-delimiter=' ' | sort -n -k2
