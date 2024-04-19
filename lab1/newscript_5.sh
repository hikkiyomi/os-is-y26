#!/bin/bash

cat /var/log/anaconda/syslog | awk '$2 == "INFO" { print $0 }' > info.log
