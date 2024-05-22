#!/bin/bash

ps ax --format pid,ppid,comm --sort start | awk -v pid="$$" '{ if ($1 != pid && $2 != pid) print $1" "$3 }' | tail -n1
