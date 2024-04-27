#!/bin/bash

last_date=$( find $HOME -maxdepth 1 -type d -name "Backup-*" \
	| sort -nrt '-' -k2,4 \
	| head -n1 \
	| awk -F/ '{ print $NF }' \
	| tail -c +8 )

rm -rf $HOME/restore/
mkdir $HOME/restore/

for obj in $( find $HOME/Backup-$last_date -mindepth 1 -maxdepth 1 ); do
	if ! [[ $obj =~ \.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
		cp -rf $obj $HOME/restore/
	fi
done

