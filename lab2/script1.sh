#!/bin/bash

ps a -u root | wc -l
ps a -u root -o pid,comm | awk '{ print $1":"$2 }'

