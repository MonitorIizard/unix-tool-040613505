### 2. สร้าง `fwithNum.dat` เป็นไฟล์ที่ได้จาก `Output Redirection` เลือกแสดงรายการไฟล์พร้อมเลขบรรทัด

กํากับ ด้วยรูปแบบดังนี

`<เลขบรรทัด> <ประเภทไฟล์และสิทธิ> <ชือไฟล์>` ตัวอย่างเช่น

```bash
$ cat fwithNum.dat
1 -rw-r--r-- art
2 -rw-r--r-- d1
3 -rwxr-xr-x f*
4 -rw-r--r-- f.dat
5 -rwxr-xr-x f1*
6 -rwxr-xr-x f2*
```

<ins>answer</ins>

```bash
ls -Fla | tr -s ' ' | cut -d ' ' -f1,9 | nl > fwithNum.dat
```

<ins>breakdown</ins>
1. `ls -Fla` หมายถึง list file เเละ directory โดยเพิ่ม `indicator` ที่ `file` เเละ `dir`
   
| indicator  |  meaning |
|---|---|
| *  |  executable file |
| / | dir |

2. `tr -s ' '` = ทำการ replace ' ' ที่ซ้ำกันหลาย ๆ รอบ เป็นตัวเดียว
  ```
-s replace a repeated sequence with a single character.
  ```

3. `cut -d ' ' -f1,9` ทำการสร้าง `list` ด้วยโดยใช้ ช่องว่างเป็น `delimeter` จากนั้นเลือก ลำดับที่ 1 เเละ 9 จาก list

4. `nl > fwithNum.dat` ใส่ line เเละยัดเข้าไฟล์ `fwithNum.dat`


<hr>

### 3. จากข้อ 2. ทําให้ได้รูปแบบดังนี

`<เลขบรรทัด> <ชือไฟล์> <ประเภทไฟล์และสิทธิ>`

```bash
1. ls -lF | tr -s ' ' | tail +2 | cut -d " " -s -f 1 | nl > permission

2. ls -lF | tr -s ' ' | tail +2 | cut -d " " -s -f 9 > filenames

3.paste permission filenames > 3.answer
```

<ins>result</ins>

```bash
[03:16 PM] cs6520159 : 77 [[7]-filter] $
1	-rw-r--r--	art
2	-rwxr-xr-x	f*
3	-rw-r--r--	f.dat
4	-rwxr-xr-x	f1*
5	-rwxr-xr-x	f2*
6	-rw-rw-rw-	filenames
7	-rw-rw-rw-	permission
```

<hr>

### 4.การปรับตั้งสภาพเเวดล้อม

จงปรับตั้งสภาพแวดล้อมเพื่อแสดงข้อความว่าเป็นการเข้าใช้โฮสต์ครั้งทีเท่าไร เมื่อเข้าใช้โฮสต์แต่ละครั้ง

```bash
echo "I have been login $(expr $(last cs6520159 | wc -l) - 2) times ago"
```

<hr>

### 6.

กําหนดไฟล์ข้อมูล `avgtemp.dat` เก็บข้อมูลอุณหภูมิเฉลี่ยของแต่ละเดือนในปี และอุณหภูมิเฉลี่ย

ประจําปี ของแต่ละเมือง ในรัฐต่างๆ ตามฟิลด์ 14 ฟิลด์

| city  | state| JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|
|---|---| --- |---|---|---|---|---|---|---|---|---|---|---|
BIRMINGHAM| AL|42.6|46.8|54.5|61.3|69.3|76.4|80.2|79.6|73.8|62.9|53.1|45.6|62.2

ขอตั้ง

```bash
alias logTmp="cat ~dummy/lab8/avgtemp.dat"
```
<hr>

#### 0. มีทั้งหมดกี่รายการ
```
priTmp | tail +2 | wc -l
```

<hr>

#### 6. เเสดงชื่อเมืองที่มีอุณภูมิเฉลี่ยต่ำสุดในเดือน เมษายน เดือน 4

```bash
logTmp | tr ',' '|' | tail +2 | cut -d'|'  -f1,6 | sort -t'|' -k2 -nr
```

<hr>

#### 7. แสดงรายชือเมืองทีมีอุณหภูมิเฉลียสูงสุด 10 อันดับแรกของเดือนธันวาคม

<ins>command</ins>

```bash
[05:50 PM] cs6520159 : 4 [~] $ logTmp | tr ',' '|' | tail +2 | cut --delimiter='|' --fields=1,15 | tail +2 | sort --field-separator='|' --key=2 | tail -10
```

<ins>breakdown</ins>

1. `logTmp` เป็น `alias` cat file `~dummy/lab8/avgtemp.dat`
2. `tr ',' '|'` ทำการ `replace​ : ,` เป็น `|`  จาก `BIRMINGHAM, AL|` $\rightarrow$ `BIRMINGHAM|AL|`
3. `tail +2` crop เอาบรรทัดที่ 2 จากต้น line สู่บรรทัดสุดท้าย
4. `sort --field-separator='|' --key=2` sort field ที่ 2 โดยเเยก `field` ด้วย `|`, field ที่ 2 เป็น `avg temp`
5. `tail -10` เลือกบรรทัด `10` บรรทัดล่าง เนื่องจากผลลัพธ์หลัง `sort` ค่าที่ได้จะเรียงจากน้อยไปมาก 

ดังนั้นจะได้

```bash
BROWNSVILLE|73.3
HILO|73.9
FORT MYERS|74.9
WEST PALM BEACH|75.3
YUMA|75.3
LIHUE|75.7
KAHULUI|75.8
MIAMI|76.7
HONOLULU|77.5
```


Note :
`--key=KEYDEF
  sort via a key; KEYDEF gives location and type`

`
 KEYDEF is F[.C]
 where F is a field number
`

| word  | meaning  |
|---|---|
| delimeter  | symbol for seperate item |  


<hr>

Note :

| command  |  meaning |
|---|---|
| `cut -c1-3`  |  ตัดตัว str ลำดับที่ 0 - 3 เช่น จากคำ HelloWorld $\rightarrow$ Hel |
|`tr '\|' ','`| เปลี่ยนจาก `\|` เป็น `,`|
|`sort`|
