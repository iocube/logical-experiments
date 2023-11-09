#!/bin/bash

star_symbol='*'
total_lines='9'  # total amount of printed lines ( greater than 0 )
counter="$total_lines"  # internal counter

function repeat_letter {
	letter="$1"
	times="$2"
	times_counter=0
	if [[ $times -le '0' ]];then times=$(( times * times )) ;fi 
	repeated=''
	while [[ "$times_counter" -ne "$times" ]]; do
		repeated+="$letter"
		times_counter=$(( $times_counter + 1 ))
	done
	echo "$repeated"
}

function create_range {
	# because bash doesn't want to expand a range in the for loop statement fuck
	# so we're just gonna echo it in its entirety
	counter="$1"
	current_count=0
	while [[ ${counter} -ne '0' ]]; do 
		range+="$current_count "
		current_count=$((current_count + 1 ))
		counter=$((counter - 1 ))
       	done
	echo "$range"
}

function middle_point {
	current_line="$1"
	entire_range="$2"
	entire_range=$(echo $entire_range | sed -r 's/ /,/g')  # change range separators
	entire_range="[$entire_range]"

	# find midpoint of the range
	mid_point=$(python3 -c "from statistics import median; print(median($entire_range))")

	# compare if we're past it
	if [[ "$current_line" -ge "$mid_point" ]];then
		past_midpoint=1
	else
		past_midpoint=0
	fi
}

function num_whitespaces {
continue
}



loop_range=$(create_range $counter)
#loop_range_max="$(echo $loop_range | sed -r 's/^.* ([0-9]+)$/\1/g')"  # find last number of the range
loop_range_max=4  # why does 4 JUST work?!

for line_num in $loop_range; do
	middle_point $line_num "$loop_range"  # check if we've reached the middle point
	
	num_repeat="$mid_point"  # original assignment, will be altered in later iterations
	case $past_midpoint in
		0)
			num_repeat=$(( mid_point - line_num ))  # spaces before
			opposite_repeat=$(( line_num + line_num ))
			echo "$(repeat_letter ' ' ${num_repeat})${star_symbol}$(repeat_letter "$star_symbol" ${opposite_repeat})"
			;;
		1)
			num_repeat=$(( line_num - mid_point ))  # spaces before
			opposite_repeat=$(( line_num + line_num - (num_repeat*loop_range_max) ))
			echo "$(repeat_letter ' ' ${num_repeat})${star_symbol}$(repeat_letter "$star_symbol" ${opposite_repeat})"
			;;
		*)
			echo "Incorrect case." && exit 1
			;;
	esac

	counter=$(( counter - 1 ))
done
