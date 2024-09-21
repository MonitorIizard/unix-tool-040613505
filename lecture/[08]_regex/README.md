### dummy file

```bash
Mathematics  ma  
Industrial Chemistry ic

Computer Science 
cs
css
mcs

spg pls ydt srr lpp aws csj nsd nsr

c# assembly java

```

<hr>

### RegEx ex1

```bash
[10:07 AM] cs6520159 : 19 [regex] $ grep [A-Z] dummy
```

**output**

```bash
Mathematics  ma  
Industrial Chemistry ic
Computer Science
```

explaination : in the line that have capital letter will be taked.

### RegEx ex2

```bash
[10:08 AM] cs6520159 : 24 [regex] $ grep [^a-z] dummy
```
**output**

```bash
Mathematics  ma  
Industrial Chemistry ic
Computer Science 
spg pls ydt srr lpp aws csj nsd nsr
c# assembly java
```

### RegEx ex3 `cs` vs `^cs`

**output**

```bash
[10:14 AM] cs6520159 : 25 [regex] $ grep cs dummy
Mathematics  ma  
cs
css
mcs
spg pls ydt srr lpp aws csj nsd nsr
```


```bash
[10:15 AM] cs6520159 : 26 [regex] $ grep ^cs dummy
cs
css
```

hyphotesis : `^cs` mean choose only the line that start with `cs`

<hr>

### RegEx ex 4 `^[cs]`

```bash
[10:24 AM] cs6520159 : 61 [regex] $ grep ^[cs] dummy | nl
     1	cs
     2	css
     3	spg pls ydt srr lpp aws csj nsd nsr
     4	c# assembly java
```



<hr>

| symbol  |  name |
|---|---|
| `^`  | circumflex  |
