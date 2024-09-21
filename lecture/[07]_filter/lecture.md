## research later
1. `tar`

<hr>

21/08/2027

ไฟล์ `/dev/tty` เป็นปลายทางที่เมื่อใส่ `stdin` เข้าไปจะ `stdout` ขึ้นมผ่านทาง `monitor`

`for e.g` 
`cat w2 > d` จะไม่เเสดง `stdout` ออกมาทาง `monitor` เเต่หากใช้ `cat w2 > d > /dev/tty` เราจะได้ เนื้อหา `w2` ด้วย

```bash
cat w2 > d
```

```bash
cat w2 > d >& /dev/tty
cs6530375 pts/0        2024-08-21 10:02 (202.44.40.186)
cs6520027 pts/1        2024-08-21 09:06 (202.44.40.186)
cs6520035 pts/2        2024-08-21 09:06 (202.44.40.186)
cs6510188 pts/3        2024-08-21 09:06 (202.44.40.186)
cs6530243 pts/4        2024-08-21 09:58 (202.44.40.186)
cs6530332 pts/5        2024-08-21 09:57 (202.44.40.186)
cs6530090 pts/6        2024-08-21 09:56 (202.44.40.186)
```

<hr>

## Filter
คือคำสั่งที่ `transform` หรือ `filter` `stdin`
| command  | note  |
|---|---|
|  `cat`  (concatenate)|   |
| `more`||
| `less`||
| `tail`| นับบรรทัดจาก `bottom`|
|`head`| นับบรรทัดจาก `Top`|
|`cut`||
|`paste`||
|`sort`||
|`unique`| ทำการ `display` ข้อมูลตัวเดียว ลบ `duplicate` ต้อง `adjacent` ก่อน เพื่อให้ข้อมูลติดกัน |

Delimited = เเปลว่าตัวคั่น `default is tag`

## Demo 1
1. จัดลำดับการเข้าใช้ 
**จุดประสงค์ :** หาความถี่ของ `user` ที่เข้ามาใช้งานระบบ ตั่งเเต่วันที่ 20 บ่อยที่สุด

  ```bash
last | nl > /dev/tty | wc -l 
  ```
last บอกถึง history ที่ user ล็อกอินมา

เราต้องการบรรทัดของวันที่ `118`
```bash
 118	cs653009 pts/1        184.22.105.189   Tue Aug 20 22:05 - 00:17  (02:12)
```


ดังนั้น เราเพิ่ม  `head -118` เข้าไป บอกว่าเอาบรรทัด 1 - 118

```bash 
last | nl | head -118 
```


``` bash
last | head -682 | tail +1 | cut -c-8 | sort | uniq -c | sort -n
```

<hr>

## Demo 2 : grep
จุดประสงค์ : grep ชื่อจังหวัง `พระนคร`

<hr>

## Lab 8 ชี้เเจง
ข้อ 6 `avgtemp.dat` 


## Midterm
| How to use  | description  |
|---|---|
| คำสั่งอะไร  |  อธิบายว่าคำสั่งนั้นใช้ทำงานอะไร |

