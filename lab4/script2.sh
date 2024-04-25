#!/bin/bash

get_copy_number() {
	last_number=$( find $1 -type f \
	       		| grep -e "/$2" \
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

if [[ $# -ne 1 ]]; then
	echo "Exactly one parameter should be passed to the script."
	exit 1
fi

OLDIFS=$IFS
IFS=$'\n'

set -f

new_trash_log=$( mktemp )

for line in $( cat $HOME/.trash.log ); do
	last_path=$( awk '{ print $1 }' <<<$line )
	trash_file=$( awk '{ print $2 }' <<<$line )

	if ! [[ $last_path = */$1 ]]; then
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
		if ! [ -f $new_path ]; then
			break
		fi

		read -p "There is already a file with such name. Do you want to create a copy (1) or give the file a new name (2)? " answer

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

