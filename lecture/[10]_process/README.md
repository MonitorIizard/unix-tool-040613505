# Team workshop

Next week have quiz.

# process

## process hierachy
```bash
> pstree

systemd─┬─ModemManager───2*[{ModemManager}]
        ├─agetty
        ├─apache2───6*[apache2]
        ├─containerd───8*[{containerd}]
        ├─cron
        ├─dbus-daemon
        ├─dockerd───9*[{dockerd}]
        ├─dockerd─┬─containerd───8*[{containerd}]
        │         └─12*[{dockerd}]
        ├─irqbalance───{irqbalance}
        ├─mariadbd───6*[{mariadbd}]
        ├─master─┬─2*[cleanup]
        │        ├─local
        │        ├─pickup
        │        ├─qmgr
        │        └─trivial-rewrite
        ├─multipathd───6*[{multipathd}]
        ├─networkd-dispat
        ├─packagekitd───2*[{packagekitd}]
        ├─polkitd───2*[{polkitd}]
        ├─rsyslogd───3*[{rsyslogd}]
        ├─snapd───8*[{snapd}]
        ├─sshd─┬─25*[sshd───sshd───bash]
        │      ├─sshd───sshd───sftp-server
        │      ├─sshd───sshd───bash─┬─man───pager
        │      │                    └─2*[top]
        │      └─sshd───sshd───bash───pstree
        ├─supervisord
        ├─27*[systemd───(sd-pam)]
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-network
        ├─systemd-resolve
        ├─systemd-timesyn───{systemd-timesyn}
        ├─systemd-udevd
        ├─udisksd───4*[{udisksd}]
        ├─unattended-upgr───{unattended-upgr}
```

ps -axl

```bash
[09:39 AM] cs6520159 : 6 [~] $ id
uid=1234(cs6520159) gid=1002(std) groups=1002(std)
```

our bash

```bash
[09:39 AM] cs6520159 : 7 [~] $ ps
    PID TTY          TIME CMD
3975331 pts/26   00:00:00 bash
3976401 pts/26   00:00:00 ps
```

parent

```bash
[09:40 AM] cs6520159 : 10 [~] $ ps -axl | grep 3975331
this is parent. --> 0  1234 3975331 3975330  20   0   9200  5552 do_wai Ss   pts/26     0:00 -bash  
                    0  1234 3976591 3975331  20   0  10464  3192 -      R+   pts/26     0:00 ps -axl
                    0  1234 3976592 3975331  20   0   7008  2172 pipe_r S+   pts/26     0:00 grep --color 3975331
```


<hr>

## STATe
| state | meaning                                                |
| ----- | ------------------------------------------------------ |
| D     | wait                                                   |
| I     | idle for 20 sec                                        |
| R     | that process still running                             |
| Z     | Zombie, Admin have to delete (infinite loop)           |
| Z     | Zombie, Admin have to delete (infinite loop)           |
| +     | Foreground process, the responsibility for that moment |
| s     | indicates are session leaders (bash)                   |

## Job control commands
Owner can choose what to be foreground and background.

but background and foreground, still use `stdinput` and `stdoutput`.

### Job commands
| Command | Significance            |
| ------- | ----------------------- |
| fg      |                         |
| bg      |                         |
| kill    |                         |
| jobs    | list active job         |
| suspend | command                 |
| ^z      | is signal for stop      |
| ^c      | is signal for terminate |

We use signal when mother is sleep, because we can't use `command`.

We can execute `command1`  and mother is stll sleep, we can use `bg` to move the process to background, and get promtback to continue our work.

```bash
[09:59 AM] cs6520159 : 17 [~] $ jobs
[1]-  Stopped                 ping 202.44.40.193
[2]+  Stopped                 vi
```
[2] is the present process. cause it have `State` +.

Then foreground job 1.

```bash
[10:00 AM] cs6520159 : 20 [~] $ fg 1
ping 202.44.40.193
64 bytes from 202.44.40.193: icmp_seq=14 ttl=64 time=0.111 ms
64 bytes from 202.44.40.193: icmp_seq=15 ttl=64 time=0.099 ms

^Z
[1]+  Stopped                 ping 202.44.40.193
[10:01 AM] cs6520159 : 21 [~] $ jobs
[1]+  Stopped                 ping 202.44.40.193
[2]-  Stopped                 vi
```

Now, job `1` is forground with `+` state indicate.

If we `background bg`, that process, yes we get prompt back but the process still running, still `stout`

```bash
64 bytes from 202.44.40.193: icmp_seq=83 ttl=64 time=0.055 ms
ps
    PID TTY          TIME CMD
3980919 pts/35   00:00:00 bash
3980993 pts/35   00:00:00 ping
3981000 pts/35   00:00:00 vi
3981936 pts/35   00:00:00 ps
[10:06 AM] cs6520159 : 12 [~] $ 64 bytes from 202.44.40.193: icmp_seq=84 ttl=64 time=0.076 ms
```

foreground: user will always interact.
command will be executed until it end.

Orphan process: when we want to execute the process for the long time without login
but logout, bash will be kill so that process won't work.

So we have to make the `Ophan process` with `nohub`

or take it to `background` process.

### Ophan

ping cloud.google.com >log & 

`find / -mtime +30 >find.log`


### cront tab

- cron daemon
- crontab entry
- store email.

- 00 - 10
- 3, 6
- Override

#### We will use `crontab` to create echo command every 10 seconds.

```
crontab -e 
then edit the file.
```

