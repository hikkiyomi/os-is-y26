#!/bin/bash

get_copy_number() {
	last_number=$( find $1 -type f \
	       		| grep -F "/$2" \
		       	| awk -F/ '{ print $NF }' \
		       	| awk -F_ '{ print $NF }' \
		       	| grep -E "[0-9]+" \
		       	| sort -rn \
			| head -n1 )

	if [[ -z $last_number ]]; then
		echo 1
	else
		echo $(( last_number + 1 ))
	fi
}

exist() {
	path=$1
	existing=$( find $2 -mindepth 1 -maxdepth 1 )
	result=$( grep -F "$path" <<<$existing )

	if [[ -n "$result" ]]; then
		return 0
	fi

	return 1
}

if [[ $# -ne 1 ]]; then
	echo "Exactly one parameter should be passed to the script." >&2
	exit 1
fi

if ! grep -qF -- "$1" $HOME/.trash.log; then
	echo "No $1 found in trash." >&2
	exit 1
fi

OLDIFS=$IFS
IFS=$'\n'

set -f

new_trash_log=$( mktemp )

for line in $( cat $HOME/.trash.log ); do
	last_path=$( awk -F/ '{ for (i = 1; i < NF - 1; ++i) printf $i "/"; print $(NF - 1) }' <<<$line )
	trash_file=$( awk -F/ '{ print $NF }' <<<$line )

	if ! grep -qF "/$1" <<<$last_path; then
		echo "$line" >>$new_trash_log

		continue	
	fi

	read -p "Restore the file $last_path? [y/n] " answer

	if [[ $answer == "n" ]]; then
		echo "$line" >>$new_trash_log

		continue
	fi

	need_to_delete=$(( ${#1} + 2 ))
	directory=$( head -c -$need_to_delete <<<$last_path )

	if ! [ -d $directory ]; then
		echo "Initial directory $directory does not exist anymore. Restoring file into home directory."
		directory=$HOME
	fi
	
	new_path="$directory/$1"

	while true; do
		if ! exist $new_path $directory; then
			break
		fi

		read -p "There is already a file / directory with such name. Do you want to create a copy (1) or give the file a new name (2)? " answer

		case $answer in
			1)
				copy_number=$( get_copy_number $directory $1 )
				new_path="$new_path"_"$copy_number"
				;;
			2)
				read -p "Enter new name: " new_name
				new_path="$directory/$new_name"
				;;
			*)
				echo "Wrong input. Try again."
				;;
		esac
	done

	ln $HOME/.trash/$trash_file $new_path
	rm -f $HOME/.trash/$trash_file
done

set +f
IFS=$OLDIFS

mv -f $new_trash_log $HOME/.trash.log

