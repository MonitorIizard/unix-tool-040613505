TODO
ข้อ 6 c
คำถาม 6.2 Q8, Q10, Q11, Q13
ข้อ 12,13, 14
ข้อ 17 b, g

จุดประสงค์
1. เข้าใจ `command execution`
2. เข้าใจ `Quoting`
3. เข้าใจ `Command substitution`
4. อธิบายการใช้งาน `alias` เเละ สภาพเเวดล้อม

### 1. ทดลองป้อนคำสั่ง เเละสังเกตผลลัพธ์
**Command :**

```bash
( date ; who | nl ) > nowinfo
```

**meaning :**

1. display current date and time 

``` bash
date
Thu Aug 22 11:09:57 +07 2024
```

2. ทำการ excute `who` ซึ่งเป็นการหาว่าใคร `Loged in ` อยู่ในระบบตอนนี้บ้าง

``` bash
who
cs6520159 pts/0        2024-08-22 10:58 (184.22.10.23)
```

3. นำ `stdoutput` จาก คำสั่ง `who` ไปเป็น `stdinput` ให้กับ คำสั่ง `nl` เพื่อนับจำนวน `line` ด้วย `| (pipe)`

```bash
who | nl
     1	cs6520159 pts/0        2024-08-22 10:58 (184.22.10.23)
```

4. คำสั่ง `( date ; who | nl ) > nowinfo` จะได้ผลลัพธ์

```bash
(date ; who | nl ) > nowinfo > /dev/tty
Thu Aug 22 11:15:55 +07 2024
     1	cs6520159 pts/0        2024-08-22 10:58 (184.22.10.23)
```

หมายถึงการนำผลลัพธ์จากคำสั่ง `(date ; who | nl )` ไปใส่ในไฟล์ `nowinfo` เเละสาเหตุที่ `date` ไม่ถูกใส่ `line number` เพราะ มีเพียงคำสั่ง `who` ที่ถูกส่ง `stdoutput` $\rightarrow$ `nl`

<hr>

## Command substitution

|   | How to use  |
|---|---|
| 1  | `command`  |
| 2 | `$(command)`|a. 1

### 3. ให้ทดลองป้อนคำสั่ง เเละสังเกตผลลัพธ์

|   | command  | meanin |
|---|---|---|
|  a. 1 |  `ls hw*`   | ทำการ list `dir` หรือ `file` ที่มี pattern ชื่อไฟล์ `hw*`   |
| a. 2 | `grep 'the' %(ls hw*)`|  หา pattern `the` จาก `file` ใน list ของ `a.1`|

```bash
.
├── first.txt
├── hw
│   ├── the1
│   └── the2
├── hw1
├── hw2
└── second.txt
```

นี่คือ tree ของ `folder` ปจบ


```bash
ls hw*
hw1  hw2

hw:
the1  the2
```

โดยคำสั่ง `grep 'the'` = หา pattern `the` จาก ไฟล์ที่ตามมาด้านหลัง นั้นคือ `hw1` `hw2` เเละ `hw: the1 the2`

โดยในไฟล์ `hw1` เเละ `hw2` 

|   | content  |
|---|---|
| hw1  | the Nemo  |
| hw2|the universe does not give a fuck about you |

ทำให้เราเจอ `the` ทั้งสองไฟล์ เเต่เนื่องจาก `hw:` ที่ return มาจาก `ls hw*` ไม่ใช้ไฟล์ เเต่เป็น `directory` ทำให้ไม่สามารถ `grep` ได้

เเละ `the1` กับ `the2` อยู่ใน dir `/hw/the1` เเละ `/hw/the2` การใส่ `grep 'the' the1 the2` ทำให้ไม่สามารถหา pattern ในไฟล์ `the1 the2` ได้เพราะมันไม่มี !!


```bash
grep 'the' $(ls hw*)
hw1:the Nemo
hw2:the universe does not give a fuck about you
grep: hw:: No such file or directory
grep: the1: No such file or directory
grep: the2: No such file or directory
```

<hr>

|   | command  | meaning|
|---|---|---|
| b.1 |  `who \| wc -l` | นับ `line` คนที่กำลัง `login` อยู่ในตอนนี้|
|b.2|`who \| wc -l > u.log`| นำผลลัพธ์จาก  `b.1` ไปใส่ใน `u.log`  |
| b.3|`echo "There are $(who \| wc -l) users now"`|`display` ข้อความ ที่มีการเเทนที่ด้วยผลลัพท์ `b.1`|
|b.4|`echo "There are $(who \| wc -l) users now" > u.log`|ทำการบันทึกข้อความ `b.3` ลงไฟล์ `u.log`|
| c.1  |` cd;pwd`  | กลับสู่ `home dir` เเละพิมพ์ path ปจบ|
| c.2  |  `echo My home directory is cd;pwd` | เเสดง `string` + `path` ปจบ ไม่มีการ `cd` กลับไป `home dir` เพราะ `cd` เป็น `string` ตัวนึง|
| c.3  |   `echo "My home directory is cd;pwd"`|พิมพ์ชุดข้อความทุกอย่างที่อยู่ใต้ `" message "`|
| c.4  |  `echo “My home directory is $(cd;pwd)”` | ทำการ `print string` + `dir` ปจบ ไม่มีการ `cd` ไปยัง `home dir` เพราะ `$(cd;pwd)` เป็น `subshell` ที่จะถูกทำลายเมื่อ command นั้นสำเร็จ หรืออีกความหมายนึงคือ `$(cd;pwd)` ทำการ `cd` ไปยังใน  `home dir` ใน `subshell` ไม่ใช่ `main shell`|

<hr>

### 4. จงใช้ Metacharacter ที่เหมาะสมเพื่อให้เชลล์ตีความตามความต้องการดังนี้

|   | requirement  | command & step|
|---|---|---|
|C1| สร้างตัวเเปร dummy เก็บ path ไดเรคทอรี่ปจบ โดยการใช้ Command Substitution  | `DUMMY='$(PWD)'` |
|C2| ใน my lab สร้างไฟล์ dummy จากการ output redirection ดังนี้ 
||**บรรทัดเเรก** เก็บค่าตัวเเปร dummy| `(echo $DUMMY; echo ""; whoami) > dummy`|
||**บรรทัดสอง** เว้นบรรทัด||
||**บรรทัดสามเก็บ** username ของตนเอง `whoami` ||

### Q3 : จากข้อ 4 C ให้เพิ่มข้อความต่อท้ายไฟล์ `dummy`
ใช้ `>>` สำหรับการ `append` output เข้าไปในไฟล์ โดยไม่เขียนทับ
```bash
echo 'My user in /etc/passwd is $(cat /etc/passwd | grep `whoami`)' >> dummy
```

ผลลัพธ์
```
cat dummy
/home/std/cs6520159

cs6520159
My user in /etc/passwd is $(cat /etc/passwd | grep `whoami`)
```

<hr>

### Q4 : สร้างไฟล์เก็บข้อมูล การค้นหาไฟล์ให้มีข้อมูลส่วนดังนี้

```
<เวลาเริ่มค้นหา>
<ผลการค้นหา>
<สิ้นสุดการค้นหา>
```

command
`date +%N; find . dummy; date +%N`

output
```bash
cat Q4
117088947
.
./dummy
./Q4
dummy
125286383
```


<hr>

### Q5: เขียนคำสั่งเเสดง
```bash
Host info: <count logged user > users 

Time:< current date by command date+%A/%d/%B/%Y%t%r>
```

command
```bash
(echo "Host info : $(who | wc -l) users"; echo "Time: $(date +%A/%d/%B/%Y%t%r)") >
```

<hr>

Note :
1. `Scalar variable` = variable ที่เก็บค่าได้เเค่ตัวเเปรหนึ่งต่อครั้ง
2. เวลาประกาศตัวเเปร ประกาศติดกันเพราะ `unix` จะคิดว่า ช่องว่างจะเป็น `arguement`
3. ใช้ `>>` สำหรับการ `append` output เข้าไปในไฟล์ โดยไม่เขียนทับ
