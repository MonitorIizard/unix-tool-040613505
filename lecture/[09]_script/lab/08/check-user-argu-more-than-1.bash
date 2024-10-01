#!/bin/bash
if (( $# > 0 ))
  then
    for i in $*
      do
        echo "Date and time is: $(date)"
          if who | grep $i >/dev/null
            then  
              echo "$i is log in"
            else
              echo "$i is not log in"
          fi
    done
  else
    echo "Please input argument, at least one."
    exit 1
fi