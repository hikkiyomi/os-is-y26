#!/bin/bash

( crontab -l 2>/dev/null ; echo "5 * * * 4 $HOME/lab3/script1.sh" ) | crontab
