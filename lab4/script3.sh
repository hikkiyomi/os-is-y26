#!/bin/bash

date_from_timestamp() {
	echo $( date -d @$1 +"%Y-%m-%d" )
}

timestamp_from_date() {
	echo $( date --date="$1" +"%s" )
}

get_difference_in_days() {
	last=$1
	cur=$2

	diff=$(( (cur-last)/86400 ))

	echo $diff
}

get_name() {
	echo $( awk -F/ '{ print $NF }' <<<$1 )
}

get_size() {
	echo $( du -sb $1 | awk '{ print $1 }' )
}

create_new_directory() {
	dst_path=$HOME/Backup-$1
	backup_report=$HOME/backup-report

	mkdir $dst_path

	{
		echo "Created backup: Backup-$1"
		echo "Content:"
	} >>$backup_report

	for obj in $( find $HOME/source -mindepth 1 -maxdepth 1 ); do
		name=$( get_name $obj )
		cp -rf $obj $dst_path

		echo "+ $name" >>$backup_report
	done

	echo "" >>$backup_report
}

redo_existing_directory() {
	dst_path=$HOME/Backup-$1
	backup_report=$HOME/backup-report

	{
		echo "Remade backup: Backup-$1"
		echo "Content:"
	} >>$backup_report

	for obj in $( find $HOME/source -mindepth 1 -maxdepth 1 ); do
		name=$( get_name $obj )
		match=$( find $dst_path -mindepth 1 -maxdepth 1 -name "$name" )

		if [[ -z $match ]]; then
			cp -rf $obj $dst_path

			echo "+ $name" >>$backup_report
		else
			last_size=$( get_size $match )
			cur_size=$( get_size $obj )

			if [[ $last_size -ne $cur_size ]]; then
				mv $match $match.$1
				cp -rf $obj $dst_path

				{
					echo "! $match $match.$1"
					echo "+ $name"
				} >>$backup_report
			fi
		fi
	done

	echo "" >>$backup_report
}

cur_date=$( date +"%Y-%m-%d" )
cur_date_timestamp=$( timestamp_from_date $cur_date )

last_date=$( find $HOME -maxdepth 1 -type d -name "Backup-*" \
       | sort -nrt '-' -k2,4 \
       | head -n1 \
       | awk -F/ '{ print $NF }' \
       | tail -c +8 )

echo $last_date

last_date_timestamp=$( timestamp_from_date $last_date )
days_passed=$( get_difference_in_days $last_date_timestamp $cur_date_timestamp )

if [[ $days_passed -gt 7 ]]; then
	create_new_directory $cur_date
else
	redo_existing_directory $last_date
fi

