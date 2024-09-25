## file1
```bash
[11:50 AM] cs652015cat test-subject/file1 at test-subject/file1
1
2
3
4
5
6
7
```

<hr>

## file2
```bash
[11:51 AM] cs652015cat test-subject/file2cat test-subject/file2
1
```

<hr>

## compare `file2` with `file1`
result 
```bash
[11:51 AM] cs652015comp test-subject/file2 test-subject/file1le2 test-subject/file1
file1 is less than file2 for 6 lines
```

## script bash
```bash
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
~
```

<hr>