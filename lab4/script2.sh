#!/bin/bash

get_copy_number() {
	last_number=$( find $1 -type f | grep -e "/$2" | awk -F/ '{ print $NF }' | awk -F_ '{ print $NF }' | grep -E "[0-9]+" | sort -rn | head -n1 )

	if [[ -z $last_number ]]; then
		echo 0
	else
		echo $(( last_number + 1 ))
	fi
}

if [[ $# -ne 1 ]]; then
	echo "Exactly one parameter should be passed to the script."
	exit 1
fi

grep -e "/$1 " $HOME/.trash.log |
while read last_path trash_file; do
	echo "Restore the file $last_path? [y/n]"
	
	read answer

	if [[ $answer == "n" ]]; then
		continue
	fi

	need_to_delete=$(( ${#$1} + 1 ))
	directory=$( head -c -$need_to_delete <<<$last_path )

	if ! [ -d "$directory" ]; then
		echo "Initial directory does not exist anymore. Restoring file into home directory."
		directory=$HOME
	fi
	
	final_path="$directory/$1"
	copy_number=$( get_copy_number $directory $1 )

	if [[ $copy_number -eq 0 ]]; then
		ln $HOME/.trash/$trash_file $final_path
	else
		ln $HOME/.trash/$trash_file $final_path.$copy_number
	fi
done

