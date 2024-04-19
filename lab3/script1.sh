#!/bin/bash

launch_time=$( date +"%Y-%m-%d_%H:%M:%S" )

{ mkdir ~/test && printf "catalog test was created successfully\n" > ~/report ; touch ~/test/$launch_time; } 2>/dev/null

{ ping www.net_nikogo.ru || printf "[$( date +"%Y-%m-%d_%H:%M:%S" )] www.net_nikogo.ru is unreachable\n"; } >> ~/report 2>/dev/null

