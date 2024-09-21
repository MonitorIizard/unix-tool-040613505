#### 6.5

```bash
find ~dummy -name *.gif -type f -size +2k 2>/dev/null | xargs -I {} cp -r -t ~/q1-162/gif-2/ {}
```

#### 6.6

```bash
find ~dummy -name *.gif -type f -size +2k | tee ~/q1-162/found-gif.log;
echo
echo "amount of files is $(wc -l ~/q1-162/found-gif.log | cut -d " " -f 1;)"
```
**note** : tee will save file and send to stdout. `tee file` not `tee 1>file`

#### 7.

หากผู้สอนกำหนดให้น.ศ. ทุกคนส่งการบ้านไว้ภายในไดเรคเทอรี่หนึ่งและต้องการรวบรวม การบ้านดังกล่าวมาตรวจ จงใช้ wildcard ที่เหมาะสมเพื่อทำคำสั่งสำเนาไดเรคเทอรี่รวม content ของ hw5-(น.ศ) จากน.ศ. กลุ่ม std60 (ข้อมูลอยู่ที่ /home/std)

```bash

mkdir -p std/{1..5}/hw5-{1..5}

std
├── 1
│   ├── hw5-1
│   ├── hw5-2
│   ├── hw5-3
│   ├── hw5-4
│   └── hw5-5
├── 2
│   ├── hw5-1
│   ├── hw5-2
│   ├── hw5-3
│   ├── hw5-4
│   └── hw5-5
├── 3
│   ├── hw5-1
│   ├── hw5-2
│   ├── hw5-3
│   ├── hw5-4
│   └── hw5-5
├── 4
│   ├── hw5-1
│   ├── hw5-2
│   ├── hw5-3
│   ├── hw5-4
│   └── hw5-5
├── 5
│   ├── hw5-1
│   ├── hw5-2
│   ├── hw5-3
│   ├── hw5-4
│   └── hw5-5

mkdir cpstd;
cp -r std/*/hw5-* cpstd/;
```

**not** : range {..} use only 2 dots.

### 8.

<ชื่อไฟล์>@<ประเภทไฟล์และสิทธิ์>@<เลขบรรทัด> 

```bash
paste command for combine linese of file together.
```

```bash
ls -la | tr -s ' ' | tail +2 | cut --delimiter=" " --fields=9
```

tr -s 

```
tr = translate or delete character
-s --squueze-repeats
```
