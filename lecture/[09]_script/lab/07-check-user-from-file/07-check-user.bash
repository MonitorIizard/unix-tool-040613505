#!/bin/bash
if [[ ! -s "$1" ]]
  then 
    echo "arguement is not a file."
    exit 1
  fi
echo "user list" >user.log

while read -r line
  do
    echo "Date and time is:$(date)" >>user.log
      if who | grep $line > /dev/null
        then
          echo "$line is log in" >>user.log
        else
          echo "$line is not log in" >>user.log
      fi
    
    echo ' '>>user.log

done < $1