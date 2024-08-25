TODO
14
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

### 6.c หากเเบ่งคำสั่งด้วย `|` ให้ป้อนคำสั่งทีละส่วน โดยใช้คียืลูกศร ( History ) ขึ้นลง เรียกคำสั่งเดิม

| | Command  |  Meaning |
| --- |---|---|
| C1 | `find/home -name "*.po"`  |  ค้นหาไฟล์ที่ลงท้ายด้วยสกุล `*.po` จากนั้น display ขึ้นมาบน `terminal`  ทั้ง `stdout` เเละ `stderr`  |
| C2| `find/home -name "*.po" 2>/dev/null` | display เเค่  `stdout` เเต่ `error` จะถูกโยนเข้า `2>/dev/null` เพราะ `2` เป็นตัวเเทน `stderr`| 
|note |`tee`| เป็นคำสั่งรับ `stdin` จากนั้นจะส่งออก `stdout` ไปสู่ไฟล์ เเละ `monitor` หากปกติเรา `redirect stdout` ไปยังไฟล์ จะไม่มีการ `stdout` $\xrightarrow{\text{display on}}$ `monitor`|
| C3 |`find/home -name "*.po" 2>/dev/null \| tee txt`| นำผลลัพธ์ที่ไม่เเสดง `err` เขียนลงไฟล์ `txt` พร้อมกับเเสดงผลลัพธ์ขึ้น monitor`|
| C4 | `find/home -name "*.po" 2>/dev/null \| tee /dev/tty \| nl`| display path ที่เจอไฟล์ นามสกุล `.po` โดยละเว้น `err`. `display` สองครั้ง จากคำสัง `tee` เเละ `/dev/tty` เเละ `stdinput` $\xrightarrow{\text{assign line by}}$ `nl`|

<hr>

### 8.

คําสั่ง `xargs`จะแบ่ง `Arguments` เป็นส่วน ๆ ส่งให้กับคําสั่งที่ไม่สามารถทํางานกับ Arguments จํานวน มากได้ให้ทดลองและสังเกตผลลัพธ์จากการใช้คำสั่ง `xargs` กับคำสั่ง `find` และเนื่องจากเป็นการลบไฟล์ ดังนั้น ให้สําเนา `~dummy/lab6/mediawiki-1.26.2` มาเป็น `media1`,`media2`,`media3`,`media4`,`media5` และ `media6` ใน ` ` ตามลําดับ เพื่อเตรียมไว้ใช้ภายหลัง

|| command  | meaning   | time |
|---|---|---| --- |
| a | `find media1 -name "*.gif"  \| nl`  | มีทั้งหมด 41 files  | |
|b| `find media1 -name "*.gif" \| xargs -n10 \| nl `| นำผลลัพธ์จาก `find media1 -name "*.gif" ` เเปลงเป็น `arguement` เเบ่งที่ละ 10 arguements เเละส่งให้กับ `nl`  | |
| c |  `find media1 -name "*.gif" -exec rm -f { } \;` | rm -f จะ executed 100 ครั้ง เพื่อลบไฟล์| |
| d | `find media2 -name "*.gif" \| xargs rm -f`| ทำครั้งเดียว rm-f `all files`| `real 0m0.279s user 0m0.093s sys	0m0.115s` |
|e| `find media3 -name "*.gif" \| xargs rm -f` | ทำการลบครั้งเดียว |`real	0m0.210s user	0m0.033s sys	0m0.118s `|


```bash
find media1 -name "*.gif" | nl
find: ‘media1/media6/resources/src/mediatest’: Permission denied
     1	media1/media6/resources/lib/oojs-ui/themes/mediawiki/images/textures/pending.gif
     2	media1/media6/resources/lib/oojs-ui/themes/apex/images/textures/pending.gif
     3	media1/media6/resources/src/jquery/images/sort_up.gif
     4	media1/media6/resources/src/jquery/images/sort_none.gif
     5	media1/media6/resources/src/jquery/images/sort_both.gif
     6	media1/media6/resources/src/jquery/images/spinner.gif
     7	media1/media6/resources/src/jquery/images/sort_down.gif
     8	media1/media6/resources/src/jquery/images/spinner-large.gif
     9	media1/media6/resources/src/mediawiki.legacy/images/ajax-loader.gif
```
vs with `xargs`

``` bash
find media1 -name "*.gif" | xargs | nl
find: ‘media1/media6/resources/src/mediatest’: Permission denied
find: ‘media1/media6/tests2’: Permission denied
     1	media1/media6/resources/lib/oojs-ui/themes/mediawiki/images/textures/pending.gif media1/media6/resources/lib/oojs-ui/themes/apex/images/textures/pending.gif media1/media6/resources/src/jquery/images/sort_up.gif media1/media6/resources/src/jquery/images/sort_none.gif media1/media6/resources/src/j
```

$\therefore$ with `xargs`  จะเป็นการ `stdin` ก้อนเดียวไปเลย ดูจากเลข 1 ในคำสั่ง `nl` ถ้าเป็น `find media1 -name "*.gif" | nl` จะได้ทั้งหมด `41 lines`


<hr>

### Q8 จงค้นหาไฟล์ `*.xml` จาก `~/lab6.2/media1` เพื่อสำเนามาไว้ที่ `~/bak` โดยใช้ `xargs` เเบ่งสำเนาครั้งละ 3 ไฟล์

```bash
find . -name "*.xml" | xargs -n3 cp -t ~/bak
```

`xargs -n3 cp -t ~/bak` เเบ่ง arguement เป็นครั้งละ 3 ชุดเข้า cp

<hr>

### Q9 จงอธิบายผลลัพธ์ของคำสั่ง

```bash
ls *.dat | xargs -t -I {} mv {} {}.bak
```

list รายชื่อไฟล์ที่มีนามสกุล `.dat` ที่อยู่ใน `dir` ปจบ $\xrightarrow{\text{output}}$ xargs $\xrightarrow[\text{and pass to}]{\text{convert to arguement}}$ `mv` $\xrightarrow[\text{add extention.bak}]{\text{rename}}$ ไฟล์ใหม่ที่มีนามสกุล `.bak` เพิ่มมา

```bash
a.dat -> a.dat.bak 
b.dat -> b.dat.bak
```

option `-I` หมายถึง `replace string` 
<hr>

### Q10 จงสร้าง Archive ชื่อ xml.tar ของไฟล์ *.xml จาก `~/lab6.2/media1`

`archive` คือ store multiple file in single file.

```bash
find ~/lab6.2/media1 -name "*.xml" 2>/dev/null | xargs -I xmlList tar -f xml.tar --append xmlList

```

1. หาชื่อไฟล์ที่ที่ลงท้ายด้วย `.xml` ในโฟลเดอร์ `/media1` หรือ `sub dir` 
$\downarrow$
2. หากมี `error` ไม่ต้องเเสดงเป็น `stdout`
$\downarrow$
3. ส่ง `stdout` เเปลงเป็น `arguement` ให้กับคำสั่ง `tar`
$\downarrow$
4. หลัง `-f` คือชื่อไฟล์ `archive` จากนั้น คำสั่ง `tar` จะสร้างไฟล์ `archive` จาก `arguement` ที่ได้จากคำสั่ง `find`
$\downarrow$
1. options `--append` จะเป็นการใส่ `file` เติมเข้าไปในไฟล์ `archive` ก่อนที่ถูกสร้าง
`create xml.tar` $\xLeftarrow{\text{append}}$ `file1`
`xml.tar` $\xLeftarrow{\text{append}}$ `file2`
`xml.tar` $\xLeftarrow{\text{append}}$ `file3`
.
.
.
on and on and on

<hr>

### Q11
จากปฎิบัติการคำสั่ง `tar` หากต้องการเรียกคืน `Archive` บางส่วนคือเฉพาะ `~/lab2/lang` ต้องใช้คำสั่งอะไร

```
-x, --extract, --get
              Extract  files  from an archive.  Arguments are op‐
              tional.  When given, they specify names of the  ar‐
              chive members to be extracted.
```

คำสั่งที่ใช้
```bash
tar -xvf lab2.tar ~/lab2/lang
```

สิ่งที่ได้
```bash
tree lab2
lab2
└── lang
     ├── basic
     │   └── i18n
     │       ├── custom
     │       └── n1.po
     └── i18n
          ├── ca.po
          └── en.po
```
<hr>

### Q13 การสร้างArchiveของ `~dummy/lab2` โดยใช้ `AbsolutePathname` ต่างจากการใช้ `Relative Pathname` อย่างไร?

archive ด้วย `tar` จะได้เก็บ `pathname` ตามที่เป็น `arguement`

1. เเบบ absolute
```bash
tar --append -f  absoulutePath.tar ~dummy/lab2
tar --list -f absoulutePath.tar

home/std/dummy/lab2/
home/std/dummy/lab2/dirA/
home/std/dummy/lab2/dirA/de.po
home/std/dummy/lab2/hw/
home/std/dummy/lab2/hw/archive.php
home/std/dummy/lab2/hw/hw4/
home/std/dummy/lab2/hw/hw4/pic-hw4.jpg
home/std/dummy/lab2/hw/hw4/hw4.txt
home/std/dummy/lab2/hw/hw4/data-hw4.txt
```
2. เเบบ relative
```bash
tar --append -f relativeName.tar ../../../../../../dummy/lab2/
tar --list -f relativeName.tar

dummy/lab2/
dummy/lab2/dirA/
dummy/lab2/dirA/de.po
dummy/lab2/hw/
dummy/lab2/hw/archive.php
dummy/lab2/hw/hw4/
```

เเบบ `absolute` จะเก็บ `path` เเบบ `fullname` 
เเบบ `relative` จะเก็บ `path` เเค่ส่วนที่เราอ้างอิงไป


<hr>

### 12. 

โดยปกติเมื่อผู้ใช้ `Login` สำเร็จ `shell` เริ่มต้นตามที่จั้งไว้ใน `/etc/passwd` จะทำงาน การตั้งค่าสภาพเเวดล้อมจะเริ่มต้นจาก `/etc/profile` เเละ `~/.bash_profile` หรือ `~/.bash_login` หรือ `~/.profile` ถ้ามีไฟล์ใดไฟล์หนึ่งตามลำดับ เมื่อผู้ใช้ `Logout` shell จะอ่าน `~/.bash_logout` ถ้ามี


#### 12.1 จงสำรวจใน ~ ว่ามี `configuration files` ใดบ้าง
| word  | meaning  |
|---|---|
| configuration  | the predefined setup for hardware or software  |

ถ้า `configuration file` คือ `file` ที่ถูกตั้งไว้เป็น default จะถูกรันเมื่อ ระบบถูกรัน
$\therefore$ `configuration files` ใน `home` ได้เเก่


```bash
.bash_logout
.bashrc
.profile
```

#### 12.2 จาก 12.1 ถ้าไม่มีไฟล์ใด ให้สร้างขึ้นเองและเพิ่มคําสั่งแสดงข้อความว่า `“This is <Conf. files>”`

```bash
echo "echo 1. 'this is .bash_profile'" | cat > .bash_profile; echo "echo 2. 'this is .bash_ login' " | cat > .bash_login
```

<hr>

#### 12.3 ทดลอง Login เพื่อสังเกต `Configuration files`

ตามลำดับเเล้วควรจะเป็น
`~/.bash_profile`
$\downarrow$
`~/.bash_login`
$\downarrow$
`~/.profile`

login ครั้งเเรก `1. this is .bash_profile` ทำการลบไฟล์ .`bash_profile` ออก

`2. this is .bash_login` ทำการลบ `.bash_login` 

```
*** System restart required ***
⬜⬛⬛⬜⬜⬜⬜⬜⬜⬜⬜🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜⬛⬛⬜
⬛🏻🏻⬛⬛⬜⬜⬜⬜🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜⬛⬛🏻🏻⬛
⬛🟧🏻🏻🏻⬛⬛⬜🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜⬛⬛🏻🏻🏻🟧⬛
⬛🟧🟧🏻🏻🏻🏻🏻🟥🟥🟥🟥🟩🟩🟩🟩🟩🟩🟥🟥🟥🟥🏻🏻🏻🏻🏻🟧🟧⬛
⬛🟧🟧🏻🏻🏻🏻🟥🟥🟥🟥🟥🟥🟩🟩🟩🟩🟥🟥🟥🟥🟥🟥🏻🏻🏻🏻🟧🟧⬛
⬛🟧🟧🏻🏻🟥🟥⬜⬜⬜⬜⬜🟥🟫🟫🟫🟫🟥⬜⬜⬜⬜⬜🟥🟥🏻🏻🟧🟧⬛
⬛🟧🟧🏻🏻🟥🟥⬜⬜⬜⬜⬜🟥🟫🟫🟫🟫🟥⬜⬜⬜⬜⬜🟥🟥🏻🏻🟧🟧⬛
⬜⬛🟧🟧🟫🟥🟥🟥🟥🟥🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟥🟥🟥🟥🟥🟫🟧🟧⬛⬜
⬜⬛🟧🟧🟫🟫🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟫🟫🟧🟧⬛⬜
⬜⬜⬛🟫🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟫⬛⬜⬜
⬜⬜🟩🟩🟩🟩🟩🟩🟩🟩🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜
⬜🟩🟩🟩🟩🟩🟧⬛⬛⬛🟧🟧🟧🏻🏻🏻🏻🟧🟧🟧⬛⬛⬛🟧🟩🟩🟩🟩🟩⬜
🟩🟩🟩🟩⬛🟧⬛🟧🟧🟫⬛🟧🏻🏻🏻🏻🏻🏻🟧⬛🟫🟧🟧⬛🟧⬛🟩🟩🟩🟩
🟩🟩🟩🟩⬛🟧🟧🟧🟧🟧🟫⬛🏻🏻🏻🏻🏻🏻⬛🟫🟧🟧🟧🟧🟧⬛🟩🟩🟩🟩
⬜⬜⬜⬛🏻🟧🟧🟧🟧🟧🟧🟧🟧🏻🏻🏻🏻🟧🟧🟧🟧🟧🟧🟧🟧🏻⬛⬜⬜⬜
⬜⬛⬛🏻🏻🟧🟧🟧⬛⬛🟧🟧🟧🏻🏻🏻🏻🟧🟧🟧⬛⬛🟧🟧🟧🏻🏻⬛⬛⬜
⬜⬛🏻🏻🏻🟧🟧⬛🟧🟧⬛🟧🟧🏻🏻🏻🏻🟧🟧⬛🟧🟧⬛🟧🟧🏻🏻🏻⬛⬜
⬜⬜⬛🏻🏻🏻🟧🟧🟧🟧🟧🟧🏻🏻🏻🏻🏻🏻🟧🟧🟧🟧🟧🟧🏻🏻🏻⬛⬜⬜
⬜⬜⬜⬛🏻🏻🏻🟧🟧🟧🟧🏻🏻🏻🏻🏻🏻🏻🏻🟧🟧🟧🟧🏻🏻🏻⬛⬜⬜⬜
⬜⬛⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🟪🟪🟪🟪🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬛⬜
⬜⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🟪🟪🟪🟪🟪🟪🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬜
⬜⬜⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🟪🟪🟪🟪🟪🟪🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬜⬜
⬜⬜⬜⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🟪🟪🟪🟪🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬜⬜⬜
⬜⬜⬜⬜⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬜⬜⬜⬜
⬜⬜⬜⬜⬜⬛🏻🏻🏻🏻🏻🏻⬛🏻🏻🏻🏻⬛🏻🏻🏻🏻🏻🏻⬛⬜⬜⬜⬜⬜
⬜⬜⬜⬜⬜⬜⬛⬛🏻🏻🏻🏻🏻⬛⬛⬛⬛🏻🏻🏻🏻🏻⬛⬛⬜⬜⬜⬜⬜⬜
⬜⬜⬜⬜⬜⬜⬜⬜⬛⬛🏻🏻🏻🏻🏻🏻🏻🏻🏻🏻⬛⬛⬜⬜⬜⬜⬜⬜⬜⬜
⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬛⬛⬛🏻🏻🏻🏻⬛⬛⬛⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜
⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬛⬛⬛⬛⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜:
Hello Nemos


b
I have been login 26 times ago
```

กลับมาเป็น `.profile` เหมือนเดิม

<hr>

### 13.  จงปรับตั้งสภาพแวดล้อมของการทํางานกับเชลล์ ที่ `~/.bash_profile` ดังนี้
#### 13.1 จากคําสั่ง `man bash` ได้แนะนําวิธีเปลี่ยนรูปแบบ Primary Prompt `$PS1` ให้ค้นหาคํา `PS1` และ `PROMPTING`เพื่อศึกษาการตั้งค่า `$PS1` ให้มีรูปแบบดังนี้

| word  |  meaning |
|---|---|
| prompt  | question to be answer , picture that help actor tell their story |


What is PS1?
`primary prompt` คือ สิ่งที่รอรับคำสั่งจากเราอยู่ตลอดเวลา
`cs6520159@momotaro` คือ `primary prompt`

command:
```bash
"PS1="\[[\@]\] \u : \# \[[\W\]] $"
```

outcome: 
```bash
[04:28 PM] cs6520159 : 1 [~] $
```

description

```bash
\@ the current time in 12-hour am/pm format       
\# the command number of this command
\W the  basename  of the current working direc‐
   tory, with $HOME abbreviated with a tilde
\u current username
\[ \] all non-priniting chracter will be printed, eg. \ [ ] *
```

<hr>

#### 13.2 ตั้ง Alias 

`alias [shortcut name] = "[command]"` to create shortcut name for frequently used command.

|index| Alias name  |  requiurement | command|
|---|---|---|---|
|1| ..  | change directory to parent dir  | `alias ".."="cd .."`|
|2|ls| ls -F | `alias "ls"="ls -l"` | 
|3|ls_-l| ls -lF| `alias ls_-l="ls -lf"`|
|4|find `<filename>`|หาไฟล์ `<filename>` ใน `~` เเสดง `pathname` เเละ `attribute` ที่ค้นพบ| `alias find='f(){ find . -name "$@" 2>/dev/null -exec ls -lh {} \; ; unset -f f; };f'`|
|5|cal| show calendar present and next month| `alias cal=’cal -A 1’`|
|6|*_path|`"echo -e '${PATH//:/\\n}'\| nl"`| `alias *_path="echo -e '${PATH//:/\\n}'\| nl`|

<ins>index 3,6</ins> : การตั้ง `shortcut name` ด้วย `alias` ไม่สามารถมีช่องว่างได้จึงเติม `_` เเทน เช่น
`ls -l` $\rightarrow$ `ls_-l`

<ins>index 4 find &#x3c;filename&#x3e; </ins>: Alias ไม่สามารถตั้งรับ parameter `filename` ได้ ดังนั้น เราจะทำการสร้างฟังก์ชั่น

<ins > to create function </ins>

```bash
alias find='f(){ find . -name "$@" 2>/dev/null -exec ls -lh {} \; ; unset -f f; }; f'
```

หน้าตาไฟล์ `.bash_profile`

```bash
PS1="\[[\@]\] \u : \# \[[\W]\] $ "
alias editP="vi ~/.bash_profile"
alias ".."="cd .."
alias "ls"="ls -F"
alias ls_-l="ls -lf"
alias find='f(){ find . -name "$@" 2>/dev/null -exec ls -lh {} \; ; unset -f f; };f'
alias cal=’cal -A 1’
alias *_path="echo -e '${PATH//:/\\n}'\| nl"
```

<hr>

### 14. จงค้นหาไฟล์ที่มีตัวเลขเป็นส่วนประกอบภายใน `~dummy/lab6/mediawiki-1.26.2/` ด้วยวิธีการต่อไปนี้

#### a. ให้เปลี่ยนทิศทางของ `Standard output` ไปลง `~/lab6.4/out.log` และ `Standard error` ไปลง ` ~/lab6.4/err.log`

```bash
find ~dummy/lab6/mediawiki-1.26.2 -name "*[0-9]*" type -f 2>~/lab6.4/err.log 1>~/lab6.4/out.log
```

#### b. ให้เปลี่ยนทิศทางของ Standard output และ Standard error ไปลงที่ไฟล์เดียวกันที่ `~/lab6.4/found.log`

```bash
find ~dummy/lab6/mediawiki-1.26.2 -name "*[0-9]*" type -f 1>~/lab6.4/out.log 2>&1
```

#### c. ให้แสดงลําดับที่ และเก็บผลลัพธ์ลงไฟล์ `~/lab6.4/num-found.log`

```bash
[06:29 PM] cs6520159 : 12 [~] $ find ~dummy/lab6/mediawiki-1.26.2 -name "*[0-9]*" |nl >~/lab6.4/num-found.log
find: ‘/home/std/dummy/lab6/mediawiki-1.26.2/resources/src/mediatest’: Permission denied
find: ‘/home/std/dummy/lab6/mediawiki-1.26.2/tests2’: Permission denied

[06:29 PM] cs6520159 : 13 [~] $ cat lab6.4/num-found.log 
     1	/home/std/dummy/lab6/mediawiki-1.26.2
     2	/home/std/dummy/lab6/mediawiki-1.26.2/opensearch_desc.php5
     3	/home/std/dummy/lab6/mediawiki-1.26.2/serialized/Utf8Case.ser
     4	/home/std/dummy/lab6/mediawiki-1.26.2/resources/assets/poweredby_mediawiki_132x47.png
     5	/home/std/dummy/lab6/mediawiki-1.26.2/resources/assets/poweredby_mediawiki_88x31.png
     6	/home/std/dummy/lab6/mediawiki-1.26.2/resources/assets/licenses/cc-0.png
     7	/home/std/dummy/lab6/mediawiki-1.26.2/resources/assets/poweredby_mediawiki_176x62.png

```

ตั้ง `alias f='find ~ -name "*[0-9]*" -type f'`

#### d. หากเริ่มค้นหาต้ังแต่ `/home` จะพบไฟล์และความผิดพลาดจํานวนมากให้สนใจเฉพาะ `Output` ที่เป็นที่อยู่ของไฟล์ที่พบ และไม่สนใจความผิดพลาดทงั้หมดหากใช้ `ErrorRedirection` จะได้ไฟล์ขนาดใหญ่ดังนั้นจะทําอย่างไรเพื่อควบคุมความ ผิดพลาดที่พบ ไม่ให้แสดงทางจอภาพ

`2>/dev/null`

#### e. จาก d. ให้แสดงลําดับที่ และจํานวนไฟล์ที่พบแสดงทาง `StandardOutput` และเก็บลงไฟล์
`f | `




<hr>

Note :
1. `Scalar variable` = variable ที่เก็บค่าได้เเค่ตัวเเปรหนึ่งต่อครั้ง
2. เวลาประกาศตัวเเปร ประกาศติดกันเพราะ `unix` จะคิดว่า ช่องว่างจะเป็น `arguement`
3. ใช้ `>>` สำหรับการ `append` output เข้าไปในไฟล์ โดยไม่เขียนทับ
4. `/dev/tty` is a special file for input and output to user terminal regardless of redirection
5. `/dev/null` ใช้ทิ้งผลลัพธ์ที่ไม่ต้องการจาก `command` หรือ `processes`
6. `/etc` = `editable text configuration
7. `/dev` = `device`
8. `/usr` = `unix system resource`
9. `xargs` = เเปลงจาก `stdinput` $\xrightarrow{\text{convert}}$ `arguement`

