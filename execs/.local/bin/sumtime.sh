#! /usr/bin/env bash

total_seconds=00
total_minutes=00
total_hours=00

for time in "$@"
do
	time=${time//;/:}
    IFS=: read -r hours minutes seconds millis <<< "$time"
    total_seconds=$((total_seconds + 10#$millis/14 + 10#$seconds + 10#$minutes*60 + 10#$hours*3600))

	total_hours=$((total_seconds/3600))
	total_minutes=$((total_seconds%3600/60))
	t_seconds=$((total_seconds%60))

	printf "%02d:%02d:%02d\n" $total_hours $total_minutes $t_seconds
done