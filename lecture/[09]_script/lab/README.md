- [LAB 10.2](#lab-102)
  - [5. การเเสดงผลลัพธ์](#5-การเเสดงผลลัพธ์)
    - [5.1 จงใช้คำสั่ง `echo` เพื่อให้ได้ผลลัพธ์ดังนี้](#51-จงใช้คำสั่ง-echo-เพื่อให้ได้ผลลัพธ์ดังนี้)
      - [answer](#answer)
    - [5.2 จากตัวอย่าง 10.5.(posit-arg) จงแก้การแสดงผลของบรรทัดทีเป็นดังนี](#52-จากตัวอย่าง-105posit-arg-จงแก้การแสดงผลของบรรทัดทีเป็นดังนี)
      - [answer](#answer-1)
      - [outcome](#outcome)
    - [5.3) สังเกตผลลัพธ์จากคําสัง printf ดังนี](#53-สังเกตผลลัพธ์จากคําสัง-printf-ดังนี)
      - [a) `printf "user: %s\nhome dir: %s\n" "$LOGNAME" "$(pwd)"`](#a-printf-user-snhome-dir-sn-logname-pwd)
        - [answer:](#answer-2)
      - [b) `printf '%3d | %04o | 0x%02x\n' 15 15 15`](#b-printf-3d--04o--0x02xn-15-15-15)
        - [answer:](#answer-3)
          - [outcome](#outcome-1)
  - [6. จากตัวอย่าง 10.1 จงแก้ไขสคริปต์ให้แสดงผลลัพธ์ลงไฟล์ user.log](#6-จากตัวอย่าง-101-จงแก้ไขสคริปต์ให้แสดงผลลัพธ์ลงไฟล์-userlog)
    - [answer :](#answer-)
  - [7. จากข้อ 6 นำสคลิปต์มารับข้อมูลจาก `user.dat`](#7-จากข้อ-6-นำสคลิปต์มารับข้อมูลจาก-userdat)
    - [answer:](#answer-4)
  - [8.](#8)
    - [8.1  ทำ `validation 1 argument`](#81--ทำ-validation-1-argument)
      - [answer:](#answer-5)
    - [8.2 ใช้ for in `$@` หรือ `for` โดยทํา validation อย่างน้อย 1 argument](#82-ใช้-for-in--หรือ-for-โดยทํา-validation-อย่างน้อย-1-argument)
      - [answer](#answer-6)
    - [8.3 รับชือผู้ใช้จากไฟล์ โดยทํา validation 1 argument และต้องเป็นไฟล์](#83-รับชือผู้ใช้จากไฟล์-โดยทํา-validation-1-argument-และต้องเป็นไฟล์)


# LAB 10.2

## 5. การเเสดงผลลัพธ์

### 5.1 จงใช้คำสั่ง `echo` เพื่อให้ได้ผลลัพธ์ดังนี้

`Output of $(who | wc-l) is <result of command who | wc -l> users`

#### answer 


echo "Output of `\$`(who | wc-l) is <result of command who | wc -l> users"

เพิ่ม `\` ข้างหน้า `$` เพื่อให้ unix ปฎิบัติกับ `metacharacter` เป็น `string` ปกติ

<hr>

### 5.2 จากตัวอย่าง 10.5.(posit-arg) จงแก้การแสดงผลของบรรทัดทีเป็นดังนี

$1 = <value of $1> $2 = <value of $2> $11 = <value of $11>

#### answer 
เเก้บรรทัดที่ 5 โดยเพิ่ม `\` ไปข้างหน้า `metacharacter $` เพื่อให้ unix `มองเป็น strin` ปกติ

```bash
1 #!/bin/bash
2 echo "Script name: $0"
3 echo "Number of arguments: $#"
4 echo "All Parameters: $*"
5 echo “\$1 = $1 \$2 = $2 \$11 = $11”
6 for arg in $*
7 do
8 echo "$arg"
9 done
```

#### outcome
```bash
cs6520159@momotaro:~/unix/lab/[9]-script$ bash var-test A B C D E F G H I J K M L N O P Q
Script name: var-test
Number of arguments: 17
All Parameters: A B C D E F G H I J K M L N O P Q
“$1 = A $2 = B $11 = A1”
A
B
C
D
E
F
G
H
I
J
K
M
L
N
O
P
Q
```

<hr>

### 5.3) สังเกตผลลัพธ์จากคําสัง printf ดังนี

`man printf`

|  command | meaning  |
|---|---|
| printf `FOMAT` `ARGUMENT`  | controls the outpust as in C printf  |
|\n| new line|


#### a) `printf "user: %s\nhome dir: %s\n" "$LOGNAME" "$(pwd)"`

```
user: cs6520159
home dir: /home/std/cs6520159/unix/lab/[9]-script
```

##### answer:
`user: %s\n`

ตรง `%s` คือที่เเทนตัวเเปร `$LOGNAME` โดยตัวเเปรมันเก็บค่า `string` ไว้ ดังนั้น จึงใช้ `%s`

`nhome dir: %s\n"`
ตรง `%s` คือที่เเทนผลลัพธ์จากคำสั่ง `pwd` 

<hr>

#### b) `printf '%3d | %04o | 0x%02x\n' 15 15 15`

##### answer:

###### outcome
```
printf '%3d | %04o | 0x%02x\n' 15 15 15
 15 | 0017 | 0x0f
```

|  specifier |  meaning |
|---|---|
| %3d  |  สำหรับพิมพ์เลขฐาน 10 โดยจะจองพื้นที่ว่างไว้ข้างหน้า 3 ตำเเหน่ง |
| %04o  |   สำหรับพิมพ์เลขฐาน 8 เพราะ o มาจาก `octal` โดยจะจองพื้นที่ไว้ 4 ตำเเหน่ง หากมีที่เหลือจะเเทนด้วย 0|
| 0%02x  |   สำหรับพิมพ์เลขฐาน 16 เพราะ x มาจาก `hexadecimal` โดยจะจองช่องไว้ 2 ช่อง หากตัวเลขมีไม่ถึงจะ เเทนด้วย 0|

ตัวอย่าง การจองช่องไว้ 24 ช่อง

```bash
cs6520159@momotaro:~/unix/lab/[9]-script$ printf '%1d | %24o | 0x%02x\n' 15 15 15
15 |                       17 | 0x0f
```

<hr>

## 6. จากตัวอย่าง 10.1 จงแก้ไขสคริปต์ให้แสดงผลลัพธ์ลงไฟล์ user.log

### answer :

script 10.1 

Synopsis : เป็น script ไว้ตรวจสอบว่า `user` ที่เราอยากตรวจสอบ `login` อยู่ไหม ดังนั้น
โดยสิ่งที่เพิ่มไปคือ `redirection` 

หากเป็น `>` หมายความว่าให้เขียนลงในไฟล์ `user.log`

หากเป็น `>>` หมายความว่าให้เขียนเพิ่มลงในไฟล์ `user.log` ในบรรทัด 5, 7

> note : หากใช้ > ในบรรทัด 5 เเละ 7 จะเป็นการเขียนทับ

```bash
1 #!/bin/bash
2 echo "Date and time is:$(date)" >user.log
3 if who | grep $1 > /dev/null
4 then
5  echo "$1 is log in" >>user.log
6 else
7  echo "$1 is not log in" >>user.log
8 fi
```

รัน script `check-user` โดย `arguement` คือ `cs6520159`
```bash
cs6520159@momotaro:~/unix/lab/[9]-script$ bash check-user cs6520159
```

ไฟล์ `user.log`
```bash
Date and time is:Tue Oct  1 07:28:28 PM +07 2024
cs6520159 is not log in
```

<hr>

## 7. จากข้อ 6 นำสคลิปต์มารับข้อมูลจาก `user.dat`

### answer:

```bash
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
```

ใช้ `file testing [[ ! -s "$1" ]]` เพื่อตรวจสอบ `parameters` ที่เป็นไฟล์มีบรรทัด > 0 ไหม 

| expression  | meaning  |
|---|---|
| -s  |  return `true` when length of file is non zero |

จากนั้นใช้คำสั่ง `while read -r line`  นำ input เเต่ละ line (ซึ่งคือ รหัสนักศึกษา cs6520159 เป็นต้น) จาก `$1` ไปเก็บไว้ที่ ตัวเเปร `$line`

ตรวจสอบว่า user เเต่ละ line ล็อกอินไหม เเละนำไปเขียนลงไฟล์ `user.log`


ตัวอย่างในไฟล์ user.log
```bash
user list
Date and time is:Tue Oct  1 08:09:07 PM +07 2024
cs6530154 is log in
 
Date and time is:Tue Oct  1 08:09:07 PM +07 2024
cs6530081 is log in
 
Date and time is:Tue Oct  1 08:09:07 PM +07 2024
cs6530057 is log in

. 
.
.

```

<hr>

## 8. 
หากพิจารณาองค์ประกอบของสคริปต์ตามตัวอย่าง 10.1 จะได้ว่า สคริปต์นีรับข้อมูลทาง Command Line Arguments
เข้ามาทํางาน โดยนํามาเป็น argument ให้คําสัง grep เพือใช้ในการตรวจสอบเงือนไขการตรวจสอบเงือนไขจะพิจารณาจาก
ค่า Exit Status ของคําสัง หากมีผลลัพธ์ใดๆ ทีอาจเกิดขึนจากเงือนไขให้ส่งออกทาง /dev/null การแสดงผลใช้คําสัง echo
โดย Quoting ให้สามารถแสดงค่าตัวแปรร่วมกับข้อความได้ อย่างไรก็ดีสคริปต์นียังคงทํางานต่อไปหากผู้ใช้ไม่ได้ป้ อน
Command Line Arguments จากตัวอย่าง 10.1 (check-user) ให้ปรับแต่ง

### 8.1  ทำ `validation 1 argument`

#### answer: 

`$# คือ ตัวเเปรเก็บ number of arguments` เราจึงเช็คด้วย `$# == 1`

```bash
#!/bin/bash
if (( $# == 1 ))
  then
    echo "Date and time is: $(date)"
      if who | grep $1 >/dev/null
        then  
          echo "$1 is log in :"
        else
          echo "$1 is not log in"
      fi
  else 
    echo "input 1 parameter only!"
    exit 1
  fi
```

<hr>

### 8.2 ใช้ for in `$@` หรือ `for` โดยทํา validation อย่างน้อย 1 argument

#### answer
ตรวจสอบ `$# > 0` เพราะ argument อย่างน้อย 1 ตัว

จากนั้นใช้ for in `$*`, โดย `$* คือ all arguments`

```bash
#!/bin/bash
if (( $# > 0 ))
  then
    for i in $*
      do
        echo "Date and time is: $(date)"
          if who | grep $1 >/dev/null
            then  
              echo "$1 is log in"
            else
              echo "$1 is not log in"
          fi
      else 
        echo "input 1 parameter only!"
        exit 1
      fi
    done
  else
    echo "Please input argument, at least one."
    exit 1
fi
```


output
```bash
cs6520159@momotaro:~/unix/lab/[9]-script/08$ bash check-user-argu-more-than-1.bash cs6520159 cs1235 
Date and time is: Tue Oct  1 08:38:06 PM +07 2024
cs6520159 is not log in
Date and time is: Tue Oct  1 08:38:06 PM +07 2024
cs1235 is not log in
```

<hr>

### 8.3 รับชือผู้ใช้จากไฟล์ โดยทํา validation 1 argument และต้องเป็นไฟล์
ตอบ เพิ่ม if [[ ! -s “$1” ]] เพื่อตรวจสอบว่า args ตัวแรกที่รับเข้ามาเป็นไฟล์หรือไม่