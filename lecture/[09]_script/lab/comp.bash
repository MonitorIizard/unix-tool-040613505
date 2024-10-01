#!/bin/bash
# Validate Three Parameters 

if [[ $# != 2 ]]
	then 
		echo 'This script requires 2 parameters. --not $#'
		echo 'Usage : comp FILE1 FILE2'
		exit 1
	fi

if [[ ! -s "$1" ]]
	then 
		echo 'FILE1 have no line.'
		echo 'Usage : comp FILE1 FILE2'
		exit 2
	fi


if [[ ! -s "$2" ]]
	then 
		echo 'FILE2 have no line.'
		echo 'Usage : comp FILE1 FILE2'
		exit 3
	fi

f1Size=$(cat $1 | wc -l);
f2Size=$(cat $2 | wc -l);

if (( f1Size > f2Size )) 
	then
		echo "file1 is more than file2 for $(expr $f1Size - $f2Size) lines"
else 
		echo "file1 is less than file2 for $(expr $f2Size - $f1Size) lines"
	fi
