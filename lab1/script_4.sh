#!/bin/bash

current_dir=$(pwd)

if [[ "$current_dir" = $HOME ]]
then
	echo $HOME
	exit 0
else
	echo "[ERROR]: Script was launched not from home directory" >&2
	exit 1
fi
