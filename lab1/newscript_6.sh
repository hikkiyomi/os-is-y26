#!/bin/bash

> full.log

grep -Eh "(WW)" /var/log/anaconda/X.log | sed "s/(WW)/Warning:/" >> full.log
grep -Eh "(II)" /var/log/anaconda/X.log | sed "s/(II)/Information:/" >> full.log

cat full.log
