- [point01_Linux基础](/class06_大数据全栈/part01_linux/point01_Linux基础/point01_Linux基础.md)
- [point02_Shell编程](/class06_大数据全栈/part01_linux/point02_Shell编程/point02_Shell编程.md)
- [point03_Linux系统管理](/class06_大数据全栈/part01_linux/point03_Linux系统管理/point03_Linux系统管理.md)
- [point04_Linux服务管理](/class06_大数据全栈/part01_linux/point04_Linux服务管理/point04_Linux服务管理.md)
- [point05_MySQL管理](/class06_大数据全栈/part01_linux/point05_MySQL管理/point05_MySQL管理.md)
- [point06_Linux集群](/class06_大数据全栈/part01_linux/point06_Linux集群/point06_Linux集群.md)
- [point07_Linux虚拟化](/class06_大数据全栈/part01_linux/point07_Linux虚拟化/point07_Linux虚拟化.md)



安装和登录命令：login、install、mount、umount、chsh、exit、last；

- 文件处理命令：file、grep、dd、find、diff、cat、ln；
- 系统管理相关命令：df、top、free、quota、at、lp、adduser、groupadd、kill、crontab；
- 网络操作命令：ifconfig、ip、ping、netstat、telnet、ftp、route、rlogin、rcp、finger、mail、 nslookup；
- 系统安全相关命令：passwd、su、umask、chgrp、chmod、chown、chattr、sudo ps、who；
- 其它命令：tar、unzip、gunzip、unarj、mtools、man、unendcode、uudecode。

# 第一篇 Linux基础篇

## 第一章 Linux基本命令

### 1.1 Linux文件目录与作用

:anchor: **在Linux系统中一切皆文件**

- 首先通常在windows中是文件的东西,它们在linux中也是文件
- 其次一些在windows中不是文件的东西, 比如进程, 磁盘, 也被抽象成了文件. 你可以使用访问文件的方法访问它们获得信息.
- 再其次,一些很离谱的东西, 比如管道, 比如/dev/zero(一个可以读出无限个0的文件) /dev/null(一个重定向进去之后就消失了的文件). 它们也是文件
- 再再其次, 类似于socket这样的东西, 使用的接口跟文件接口也是一致的.
- **带来的好处就是, 你可以使用同一套api(read, write)和工具(cat , 重定向, 管道)来处理unix中大多数的资源.这就使得组合了简单的命令和字符处理工具(awk, sed)之后, shell脚本就能发挥出强大的功能.**

:anchor: **Linux目录**

| 目录      | 作用                                                      |
| --------- | --------------------------------------------------------- |
| **/root** | 系统管理员的主目录                                        |
| **/home** | 普通用户主目录                                            |
| **/bin**  | 存放系统可执行二进制文件 :  常用命令                      |
| /sbin     | 存放二进制可执行文件，只有root才能访问                    |
| **/etc**  | 存放系统管理和配置文件                                    |
| **/opt**  | 软件安装目录 , 类型Window的除了C盘的`Program file` 文件夹 |
| **/var**  | 用于存放运行时需要改变数据的文件                          |
| **/user** | 用于存放系统应用程序，类似win系统的c:/盘的`Program file`  |
| /dev      | 设备特殊文件                                              |

### 1.2 Linux基本命令

#### :anchor:man

- 分屏的方式显示命令的帮助文档

    ```sh
    man 命令名称
    ```

- **分屏快捷键**

    | 组合键    | 用途                   |
    | --------- | ---------------------- |
    | 空格键    | 向下翻一页             |
    | Page Down | 向下翻一页             |
    | Page Up   | 向上翻一页             |
    | home      | 前往首页               |
    | end       | 前往尾页               |
    | /         | 从上至下搜索关键字     |
    | ?         | 从下至上搜索关键字     |
    | n         | 定位到下一个搜索关键字 |
    | N         | 定位到上一个搜索关键字 |
    | q         | 退出帮助文档           |

- man命令帮助信息的结构以及意义

    | 结构属性    | 含义               |
    | ----------- | ------------------ |
    | name        | 命令的名称         |
    | synopsis    | 查收的大致使用方法 |
    | description | 介绍说明           |
    | examples    | 演示               |
    | everview    | 概述               |
    | defaults    | 默认的功能         |
    | options     | 具体的可用选项     |
    | environment | 环境变量           |
    | files       | 用到的文件         |
    | see also    | 相关资料           |
    | history     | 维护历史与联系方式 |

#### :anchor:**history**

- 用于显示历史执行过的命令

- `!历史序号` : 再次执行指定记录

#### :anchor: **shutdown** 

- 命令格式

    ```sh
    shutdown [选项] [时间] [警告信息]
    ```

- 选项

    | 选项 | 说明                       |
    | ---- | -------------------------- |
    | -c   | 取消已经执行的shutdown命令 |
    | -h   | 关机                       |
    | -r   | 重启                       |

- 案例说明

    ```sh
    shutdown -r now			# -r:重启,now:现在立即执行
    shutdown -r	05:30		# -r:重启,时间:在指定时间执行,[需要占用前端]
    shutdown -r	05:30 &		# -r:重启,时间:在指定时间执行,&:把定义重启命令放入后台
    shutdown -r +10			# -r:重启,+分钟单位:在指定分钟后执行
    ```

    ```sh
    shutdown -h now			# -h:关机, now:现在立即执行
    shuddown -h 05:30		# -h:关机, 时间:在指定时间执行
    ```

#### :anchor: **reboot**

- 不需要加入过多的选项, 直接执行重启

    ```sh
    reboot					# 重启
    ```

#### :anchor: **halt** & **poweroff**

- 这两个都是关机命令，直接执行即可。

    ```sh
    halt					# 关机
    poweroff				# 关机
    ```

#### :anchor: **init**

- 是修改 Linux 运行级别的命令，也可以用于关机和重启

    ```sh
    init 0					# 关机，也就是调用系统的 0 级别
    init 6					# 重启，也就是调用系统的 6 级别
    ```

### 1.3 文件系统

#### :anchor:**date**

- 用于显示以及设置系统的时间或日期

    ```sh
    date [选项] [+指定的格式]
    ```

- 选项说明 : `-s` 设置时间

- date的日期格式说明

    | 参数格式 | 作用           |
    | -------- | -------------- |
    | %t       | Tab键          |
    | %Y       | 年             |
    | %m       | 月             |
    | %d       | 日             |
    | %H       | 小时 (00~23)   |
    | %I       | 小时 (00~12)   |
    | %M       | 分钟           |
    | %S       | 秒             |
    | %j       | 今年中的第几天 |







#### :anchor: **pwd** 

- 显示当前路径(Print Working Directory )

    ```sh
    pwd
    ```

#### :anchor: **cd** 

- 切换目录(Change Directory)

    ```sh
    cd [相对路径或绝对路径]
    ```

- 特殊符号说明

    | 符号    | 说明                       |
    | ------- | -------------------------- |
    | ~       | 代表当前登录用户的主目录   |
    | ~用户名 | 表示切换至指定用户的主目录 |
    | -       | 代表上次所在目录           |
    | .       | 代表当前目录               |
    | ..      | 代表上级目录               |

#### :anchor: **ls** 

- 查看目录下文件 

    ```sh
    ls [选项] 目录名称
    ```

- 选项

    | 选项                                      | 功能                                                         |
    | ----------------------------------------- | ------------------------------------------------------------ |
    | -a                                        | 显示全部的文件，包括隐藏文件（开头为 . 的文件）也一起罗列出来，这是最常用的选项之一。 |
    | -A                                        | 显示全部的文件，连同隐藏文件，但不包括 . 与 .. 这两个目录。  |
    | -d                                        | 仅列出目录本身，而不是列出目录内的文件数据。                 |
    | -f                                        | ls 默认会以文件名排序，使用 -f 选项会直接列出结果，而不进行排序。 |
    | -F                                        | 在文件或目录名后加上文件类型的指示符号，例如，* 代表可运行文件，/ 代表目录，= 代表 [socket](http://c.biancheng.net/socket/) 文件，\| 代表 FIFO 文件。 |
    | -h                                        | 以人们易读的方式显示文件或目录大小，如 1KB、234MB、2GB 等。  |
    | -i                                        | 显示 inode 节点信息。                                        |
    | -l                                        | 使用长格式列出文件和目录信息。                               |
    | -n                                        | 以 UID 和 GID 分别代替文件用户名和群组名显示出来。           |
    | -r                                        | 将排序结果反向输出，比如，若原本文件名由小到大，反向则为由大到小。 |
    | -R                                        | 连同子目录内容一起列出来，等於将该目录下的所有文件都显示出来。 |
    | -S                                        | 以文件容量大小排序，而不是以文件名排序。                     |
    | -t                                        | 以时间排序，而不是以文件名排序。                             |
    | --color=never --color=always --color=auto | never 表示不依据文件特性给予颜色显示。 always 表示显示颜色，ls 默认采用这种方式。 auto 表示让系统自行依据配置来判断是否给予颜色。 |
    | --full-time                               | 以完整时间模式 （包含年、月、日、时、分）输出                |
    | --time={atime,ctime}                      | 输出 access 时间或改变权限属性时间（ctime），而不是内容变更时间。 |

- 文件的详细信息，的这 7 列的含义

    ```sh
     -rwxr-xr-x. 1 root root    2294248 9月   6 2017 vim
    ```

    > 第一列：规定了不同的用户对文件所拥有的权限
    >
    > 第二列：引用计数，文件的引用计数代表该文件的硬链接个数
    >
    > 第三列：所有者，也就是这个文件属于哪个用户
    >
    > 第四列：所属组，默认所属组是文件建立用户的有效组
    >
    > 第五列：大小，默认单位是字节
    >
    > 第六列：文件修改时间
    >
    > 第七列：文件名或目录名

#### :anchor: **mkdir** 

- 创建目录（文件夹） make directories

    ```sh
    mkdir [-mp] 目录名
    ```

- 选项说明

    | 选项 | 说明                                             |
    | ---- | ------------------------------------------------ |
    | -m   | 用于手动配置所创建目录的权限，而不再使用默认权限 |
    | -p   | 选项递归创建所有目录，可以创建多级目录           |

- 案例说明

    ```sh
    mkdir lm/movie/jp/cangls		# 无法创建目录
    mkdir -p lm/movie/jp/cangls		# 可以创建多级目录
    ```

    ```sh
    mkdir -m 711 test2				# 创建自定义权限的目录
    ```

#### :anchor: **rmdir**

-  删除空目录（remove empty directories 的缩写）命令格式

    ```sh
    rmdir [-p] 目录名
    ```

    > **-p** 选项用于递归删除空目录。
    >
    >  **rmdir 命令只能删除空目录。**

#### :anchor: **touch** 

- 创建文件及修改文件时间戳 : 命令格式

    ```sh
    touch [选项] 文件名
    ```

- 文件的时间参数

    > **访问时间**（Access Time，简称 atime）：只要文件的内容被读取，访问时间就会更新
    >
    > **数据修改时间**（Modify Time，简称 mtime）：当文件的内容数据发生改变
    >
    > **状态修改时间**（Change Time，简称 ctime）：当文件的状态发生变化，就会相应改变这个时间。

- 选项说明 : 作为了解

    | 选项 | 说明                                             |
    | ---- | ------------------------------------------------ |
    | -a   | 只修改访问时间                                   |
    | -m   | 只修改数据修改时间                               |
    | -c   | 修改所有时间参数，如果文件不存在，则不建立新文件 |
    | -d   | 把文件的 atime 和 mtime 时间改为指定的时间       |
    | -t   | 后面可以跟欲修订的时间                           |

#### :anchor: **rm** 

- 删除文件或目录

    ```sh
    rm[选项] 文件或目录
    ```

- 选项说明

    | 选项 | 说明                                                         |
    | ---- | ------------------------------------------------------------ |
    | -f   | 强制删除（force）                                            |
    | -i   | 在删除文件或目录之前，系统会给出提示信息                     |
    | -r   | 递归删除，可删除指定目录及包含的所有内容，包括所有的子目录和文件 |

#### :anchor: **cp**

- 复制文件和目录

    ```sh
    cp [选项] 源文件 目标文件
    ```

- 选项说明

    | 选项   | 说明                                                         |
    | ------ | ------------------------------------------------------------ |
    | **-a** | 相当于 -d、-p、-r 选项的集合                                 |
    | -d     | 如果源文件为软链接（对硬链接无效），则复制出的目标文件也为软链接 |
    | -p     | 复制后目标文件保留源文件的属性                               |
    | -r     | 递归复制，用于复制目录；                                     |
    | -i     | 询问，如果目标文件已经存在，则会询问是否覆盖                 |
    | **-l** | 把目标文件建立为源文件的硬链接文件，而不是复制源文件         |
    | **-s** | 把目标文件建立为源文件的软链接文件，而不是复制源文件；       |
    | -u     | 若目标文件比源文件有差异，则使用该选项可以更新目标文件，     |

#### :anchor: **mv** 

- 移动文件或改名

    ```sh
    mv 【选项】 源文件 目标文件
    ```

- 选项说明

    | 选项 | 说明                                                         |
    | ---- | ------------------------------------------------------------ |
    | -f   | 强制覆盖                                                     |
    | -i   | 交互移动，如果目标文件已经存在，则询问用户是否覆盖（默认选项） |
    | -n   | 如果目标文件已经存在，则不会覆盖移动，而且不询问用户；       |
    | -v   | 显示文件或目录的移动过程；                                   |
    | -u   | 若目标文件已经存在，但两者相比，源文件更新，则会对目标文件进行升级； |

#### :anchor: **ln**

- 在文件之间建立链接（硬链接和软链接）

    ```sh
    ln [选项] 源文件 目标文件
    ```

- Linux的文件系统

    > 软链接：类似于 Windows 系统中给文件创建快捷方式
    >
    > 硬链接：文件的基本信息都存储在 inode 中，而硬链接指的就是给一个文件的 inode 分配多个文件名

- 选项说明

    | 选项 | 说明                                                         |
    | ---- | ------------------------------------------------------------ |
    | -s   | 建立软链接文件                                               |
    | -f   | 强制。如果目标文件已经存在，则删除目标文件后再建立链接文件； |

#### :anchor:file

- 查看文件类型

    ```sh
    file 文件名称
    ```

## 第二章 Linux进阶

### 2.1 文本处理

:red_circle: **stat** : 用于查看文件的具体存储信息和时间等信息 

```sh
stat 文件名称
```

:red_circle: **cat** : 用于查看纯文本文件的内容, 适合文件内容较少的文件

```sh
cat [选项] 文件名称
```

> 选项 : -n : 显示行号

:red_circle: **more** : 用于分屏查看纯文本文件的内容, 适合文件内容较多的文件

```sh
more 文件名称
```

> 可以使用快捷键阅读分屏内容

:red_circle: **head** : 用于查看纯文本文件内容的前几行

```sh
head [选项] 文件名称
```

> 选项 : `-n 数值` : 查看指定行数

:red_circle: **tail** : 用于查看纯文本文档的后 N 行或持续刷新内容 

```sh
tail [选项] 文件名称
```

> 选项 : `-n 数值` : 查看指定行数

:red_circle: **echo** : 用于在终端输出字符串或变量提取后的值 

:red_circle: **diff** : 用于比较文件的差异

```sh
diff [参数] 文件A 文件B
```

> - 参数说明
>
> | 参数   | 作用                         |
> | ------ | ---------------------------- |
> | -brief | 确认两个文件是否相同         |
> | -c     | 详细比较出多个文件的差异之处 |

:red_circle: **tr** : 替换文本文件中的字符

```sh
tr 原始字符 目标字符
```

> 可以使用正则匹配

### 2.2 打包与压缩

:red_circle: **dd** : 用于按照指定大小和个数的数据块来复制文件或转换文件 

```sh
dd 参数
```

> - 参数说明
>
> | 参数  | 作用                       |
> | ----- | -------------------------- |
> | if    | input file  输入文件的名称 |
> | of    | output file 输出的文件     |
> | bs    | 设置每个块的大小           |
> | count | 设置要复制块的个数         |

- `dd if=要复制的文件 of 要复制成哪个文件 bs=复制文件时每个块的大小 count=这些块最后是几个文件`



:red_circle:  **tar** : 用于对文件的打包压缩或解压

```sh
tar [选项] [文件参数]
```

> 参数说明
>
> | 参数 | 作用                   |
> | ---- | ---------------------- |
> | -c   | 创建压缩文件           |
> | -x   | 解压压缩文件           |
> | -z   | 用Gzip压缩或解压       |
> | -v   | 显示压缩或解压过程     |
> | -f   | 目标文件名             |
> | -t   | 查看压缩包内有哪些内容 |
> | -j   | 用bzip压缩或解压       |
> | -p   | 保留原始的权限和属性   |
> | -P   | 使用绝对路径来压缩     |
> | -C   | 指定解压的目录         |



### 2.3 查找与搜索

:red_circle: **wc** : 用于统计指定文本的行数、字数、字节数 

```sh
wc [参数] 文本文件
```

> - 参数说明
>
> | 参数 | 作用         |
> | ---- | ------------ |
> | -l   | 只显示行数   |
> | -w   | 只显示单词书 |
> | -c   | 只显示字节数 |



:red_circle: **cut** : 用于按列提取文本字符

```sh
cut [参数] 文本文件
```

> - 参数说明
>
> | 参数 | 作用               |
> | ---- | ------------------ |
> | -f   | 设置需要查看的列数 |
> | -d   | 设置间隔的符号     |



:red_circle: **grep** : 用于在文本中执行关键字搜索

```sh
grep [选项] 查找内容 [文件参数]
```

> 选项说明
>
> | 参数 | 作用                                               |
> | ---- | -------------------------------------------------- |
> | -b   | 将可执行文件（ binary）当作文本文件（ text）来搜索 |
> | -c   | 仅显示找到的行数                                   |
> | -i   | 忽略大小写                                         |
> | -n   | 显示行号                                           |
> | -v   | 反向选择------列出没有"关键字"的行                 |

- 文件参数可以是指定文件, 也可以是管道符中内容

:red_circle: **find** : 用于按照指定条件来查找文件 

```sh
find [查找路径] [选项]
```

> - 搜索范围 : 搜索的文件目录
> - 常用选项说明
>
> | 选项           | 作用                                                         |
> | -------------- | ------------------------------------------------------------ |
> | -name          | 匹配名称                                                     |
> | -prem          | 匹配权限<br />    - `mode`为完全匹配<br />    - `- mode` 为包含即可 |
> | -use           | 匹配所有者                                                   |
> | -nouser        | 匹配无所有者文件                                             |
> | -group         | 匹配所有组                                                   |
> | -nogroup       | 匹配无所有组的文件                                           |
> | -size          | 匹配文件大小,文件大小必须带单位<br />    + 表示大于指定大小<br />    -  表示小于指定大小 |
> | -mtime         | 文件修改时间匹配<br />    +n  表示n天以前<br />    - n  表示n天 |
> | -atime         | 文件访问时间匹配<br />    +n  表示n天以前<br/>    - n  表示n天以内 |
> | -ctime         | 文件权限修改时间匹配<br />    +n  表示n天以前<br/>    - n  表示n天以内 |
> | -newer f1  !f2 | 匹配比文件 f1 新且比 f2 旧的文件                             |
> | -prune         | 忽略某个文件                                                 |

:red_circle: **locate** : 快速定位文件路径,原理是事先在系统中定义locate的文件数据库,需要定期更新

1. 创建locate数据库

    ```sh
    updatedb
    ```

2. 使用命令查找文件

    ```sh
    locate 文件名
    ```

### 2.4 管道符

|

### 2.5 重定向

- 输出重定向

`>`

`>>`

`2>`

`2>>`

`&>`

`&>>`

- 输入重定向

### 2.6 vim编辑器

vim

## 第三章 Linux用户与群组

### 3.1 用户和群组概念

**:anchor: Linux中的用户和组**

- Linux是多用户, 多任务的操作系统, 并且Linux中的各种抽象信息都是文件形式
- Linux是通过用户和组以及相关权限保证系统文件的安全

**:anchor: Linux用户和组相关文件**

- /etc/passwd存放用户信息

    ```sh
    cat  /etc/passwd         #查看用户信息
    ```

    > :small_red_triangle:  `/etc/passwd ` 文件的每一行是由`:` 分隔的7个字段
    >
    > ```sh
    > panda:x:1000:1000:panda:/home/panda:/bin/bash
    > ```
    >
    > - 字段1：用户名  --> root
    > - 字段2：密码占位符  --> x （这里都是用x代替）
    > - 字段3：uid，用户id  --> 0
    > - 字段4：gid ，组id --> 0
    > - 字段5：用户描述信息  --> root
    > - 字段6：家目录  -->  /root
    > - 字段7：登录 shell

- /etc/shadow存放用户密码信息

    ```sh
    cat  /etc/shadow         #查看用户的密码信息
    ```

    >  :small_red_triangle: `/etc/shadow`文件的每一行是由`:`分隔的9个字段
    >
    > ```sh
    > panda:密码::0:99999:7:::
    > ```
    >
    > - 字段1：用户名
    > - 字段2：通过sha-512加密(二次加密，在经过第一次加密后，第二次加入随机数再次加密)的密码
    > - 字段3：最后一次修改密码距离1970年1月1日的天数间隔
    > - 字段4：密码最短有效期
    > - 字段5：密码最长有效期
    > - 字段6：密码过期前几天进行警告
    > - 字段7：账户过期后，被锁定的天数
    > - 字段8：账号失效时间距离1970年1月1日的天数间隔
    > - 字段9：未分配功能

- /etc/group存放组信息

    ```sh
    cat  /etc/group          #查看用户的组信息
    ```

    > :small_red_triangle:   `/etc/group`文件的每一行是由`:`分隔的5个字段
    >
    > ```sh
    > panda:x:1000:panda
    > ```
    >
    > - 字段1：组名称 --> root
    > - 字段2：组密码占位符  --> x
    > - 字段3：gid --> 0
    > - 字段4：组成员

**:anchor: 用户、组、文件间有三种关系**

- 用户和文件的关系只有2种， **拥有和不拥有**。
- 组和文件的关系只有2种，  **拥有和不拥有**。
- 用户和组的关系只有2种， **属于和不属于**。

**:anchor: 用户和文件的最终关系**

- 用户拥有该文件
- 用户不拥有该文件
- 用户属于某个组，某个组拥有该文件（即用户通过属于某组来拥有该文件） 

**:anchor: Linux用户类型**

- 超级用户：UID=0
- 程序用户：Rhel5/6，UID=1-499；                Rhel7，UID=1-999
- 普通用户：Rhel5/6，UID=500-65535；        Rhel7，UID=1000-60000

### 3.2 用户查看

:red_circle: **uname**: 查看系统内核与系统版本信息

> 搭配上-a 参数来完整地查看当前系统的内核名称、主机名、内核发行版本、节点名、系统时间、硬件名称、硬件平台、处理器类型以及操作系统名称等信息。  

whoami

:red_circle: **who** : 用于查看当前登入主机的用户终端信息 

:red_circle: **last** : 用于查看当前登入主机的用户终端信息

### 3.2 用户

#### :anchor: useradd

- 用户创建新的用户

    ```sh
    useradd [选项] 用户名
    ```

- 用户创建的默认选项

    - 默认的用户家目录会被存放在/home 目录中 
    - 默认的 Shell 解释器为/bin/bash 
    - 默认会创建一个与该用户同名的基本用户组 

- 新建用户系统会做三件事

    - 新建用户时，系统会将 /etc/skel 中的目录及文件拷贝到新建用户的家目录中
    - 在 /var/spool/mail 中，新建用户名的邮箱 
    - 在 /etc下的 passwd 、shadow 、group文件中，增加用户信息

- 选项说明

    | 选项 | 说明                                     |
    | ---- | ---------------------------------------- |
    | -d   | 指定用户的家目录（默认为/home/username） |
    | -e   | 账户的到期时间，格式为 YYYY-MM-DD.       |
    | -u   | 指定该用户的默认 UID                     |
    | -g   | 指定一个初始的用户基本组（必须已存在）   |
    | -G   | 指定一个或多个扩展用户组                 |
    | -N   | 不创建与用户同名的基本用户组             |
    | -s   | 指定该用户的默认 Shell 解释器            |

#### :anchor: usermod

- 用户修改用户的属性

    ```sh
    usermod [选项] 用户名
    ```

- 选项说明

    | 选项  | 说明                                                         |
    | ----- | ------------------------------------------------------------ |
    | -c    | 填写用户账户的备注信息                                       |
    | -d -m | 参数-m 与参数-d 连用，<br/>重新指定用户的家目录并自动把旧的数据转移过去 |
    | -e    | 账户到期时间                                                 |
    | -g    | 便跟所属用户组                                               |
    | -G    | 变更扩展用户组                                               |
    | -L    | 锁定用户禁止其登陆系统                                       |
    | -U    | 解锁用户,允许其登陆系统                                      |
    | -s    | 变更默认终端                                                 |
    | -S    | 查看用户状态                                                 |
    | -u    | 修改用户的UID                                                |

#### :anchor: passwd

- 用户修改用户密码, 过期时间, 认真信息等

    ```sh
    passwd [选项] [用户名]
    ```

- passwd是使用规则

    - 普通用户只能使用 passwd 命令修改自身的系统密码 
    - root 管理员则有权限修改其他所有人的密码 ,并且不需要验证旧密码

- 选项说明

    | 选项    | 说明                                             |
    | ------- | ------------------------------------------------ |
    | -l      | 锁定用户, 禁止其登陆                             |
    | -u      | 解锁用户, 允许其登陆                             |
    | --stdin | 允许通过标准输入修改用户密码                     |
    | -d      | 是该用户可以用空密码登陆                         |
    | -e      | 强制用户在下次登陆时修改密码                     |
    | -S      | 显示用户的密码是否被锁定, 以及密码采用的加密算法 |

#### :anchor: userdel

- 用于删除用户

    ```sh
    userdel [选项] 用户名
    ```

- 选项说明

    | 选项 | 说明                     |
    | ---- | ------------------------ |
    | -f   | 强制删除用户             |
    | -r   | 同时删除用户及用户家目录 |

### 3.3 群

#### :anchor: groupadd 

- 用于创建用户组

    > 常常会把几个用户加入到同一个组里面，这样便可以针对一类用户统一安排权限 

    ```sh
    groupadd [选项] 组名
    ```

- 选项说明

    | 选项                 | 说明                              |
    | -------------------- | --------------------------------- |
    | -g  \|  --gid        | 为新组使用 GID                    |
    | -K  \|  --key        | 不使用 /etc/login.defs 中的默认值 |
    | -o  \|  --non-unique | 允许创建有重复 GID 的组           |
    | -p  \|  --password   | 为新组使用此加密过的密码          |
    | -r   \|  --system    | 创建一个系统账户                  |

#### :anchor: groupdel

- 用于删除组

    ```sh
    groupdel [选项] 说明
    ```

- 选项说明

    | 选项             | 说明               |
    | ---------------- | ------------------ |
    | -r   \| --remove | 删除主目录和邮件池 |

    > 注：只能删除附加组，而不能删除主组

#### :anchor: groupmod 

- 修改组的属性

    ```sh
    groupmod  [选项] 组名
    ```

- 选项说明

    | 选项                       | 说明               |
    | -------------------------- | ------------------ |
    | -g  \|  --gid  新ID        | 更改组ID           |
    | -n  \|  --new-name  新名称 | 改名为 NEW_GROUP   |
    | -o  \|  --non-unique       | 允许使用重复的 GID |

#### :anchor: groupmems

- 修改组中的用户

    ```sh
    groupmems [选项] 用户 -g 组名
    ```

- 选项说明

    | 选项 | 说明                                             |
    | ---- | ------------------------------------------------ |
    | -a   | 将用户添加到指定的组中                           |
    | -d   | 将用户从指定组中删除  或 `gpasswd -d  用户 组名` |

### 3.4 文件权限

#### :anchor: **文件权限类型**

- **文件类型**

    | 类型 | 含义                 |
    | ---- | -------------------- |
    | -    | 普通文件             |
    | d    | 文件目录             |
    | l    | 表示为一个软连接文件 |
    | b    | 块设备文件           |
    | c    | 字符设备文件         |
    | p    | 管道符文件           |

- **文件和文件夹权限说明**

    | 权限  | 文件类型             | 文件夹类型                            |
    | ----- | -------------------- | ------------------------------------- |
    | r = 4 | 可以读取文件         | 可以列出目录内容 , 前期是可以进入     |
    | w = 2 | 可以对文件内容做修改 | 可以在目录中增删改查, 前期是可以进入  |
    | x = 1 | 文件可执行           | 可以进入目录,不一定能读取目录内的内容 |

####:anchor: **查看文件权限**

- **命令 : ls -al ( 查看文件详细信息 )**

    ```sh
    drwxrwxr-x. 2 panda panda  6 9月   4 21:37 dir
    ```

    > :small_red_triangle: 文件详细信息描述
    >
    > - 第一组 : ( d ) : 表示文件类型
    > - 第二组 : ( rwx ) : 文件所有者的权限
    > - 第三组 : ( rwx ) : 文件所在组同一组的用户的权限
    > - 第四组 : ( rwx ) : 
    > - 第五组 : ( n )文件的链接数是
    > - 第六组 : 代表该文件的所属用户
    > - 第七组 : 代表该文件所属的组
    > - 第八组 : 代表文件的大小
    > - 第九组 : 代表文件最后的修改日期
    > - 第十组 : 文件名

#### :anchor:  chmod

- 操作文件权限

    ```sh
    chmod [权限选项] 文件或目录
    ```

- 案例 : 修改文件的权限

    ```sh
    chmod  755 文件名称 			# 给文件添加3组权限rwxr-xr-x
    
    chmod u=rwx,g=rx,o=rx 文件名称 	# 权限分别是 : u=用户权限，g=组权限，o=不同组其他用户权限
    
    chmod u-x,g+w 文件名称			# 去除用户执行的权限，增加组写的权限
    
    chmod  a+r	文件名称			# 给所有(ALL)用户添加读的权限
    ```

#### :anchor: chown  & chgrp

- 修改文件的所有者

    ```sh
    chown 新用户名 原文件				# 改变原文件的所有者
    chown -R 新用户名 原目录			# 改变原目录以及子目录的所有者
    
    chgrp 新组名 原文件				# 改变原文件的所有组
    chgrp -R 新用户名 原目录			# 改变原目录以及子目录的所有组
    ```



## 第四章 系统检测指令

### 4.1 系统相关术语

### 4.2 系统检测常用指令

:red_circle: **sosreport** : 用于收集系统配置及架构信息并输出诊断文档 

:red_circle: **uptime** : 查看系统发负载信息

> - 可以显示当前系统时间、系统已运行时间、启用终端数量以及平均负载值等信息。
> - 平均负载值指的是系统在最近 1 分钟、 5 分钟、 15 分钟内的压力情况 
> - **尽量不要长期超过 1，在生产环境中不要超过 5 **

:red_circle: **free** : 用于显示当前系统中内存的使用量信息

```sh
free -h
```

> 使用-h 参数以更人性化的方式输出当前内存的实时使用量信息 

| 内存总量 | 已用量 | 可用量 | 进程共享 内存量 | 磁盘缓存 的内存量 | 缓存的 内存量 |
| -------- | ------ | ------ | --------------- | ----------------- | ------------- |
| total    | used   | free   | shared          | buffers           | cached        |

:red_circle: **ps** : 用于查看系统中的进程状态

```sh
ps [选项]
```

> - 选项说明
>
> | 选项 | 作用                   |
> | ---- | ---------------------- |
> | -a   | 显示所有进程           |
> | -u   | 用户及其他详细信息     |
> | -x   | 显示每有终端控制的进程 |

- Linux中的五种进程状态

    | 状态         | 说明                                   |
    | ------------ | -------------------------------------- |
    | R - 运行     | 正在运行或运行队列中                   |
    | S - 中断     | 进程处于休眠中, 适当条件时会脱离该状态 |
    | D - 不可中断 | 进行不响应系统异步信号                 |
    | Z - 僵死     | 进程已经终止                           |
    | T - 停止     | 进程收到停止信号后停止运行             |

- `ps aux`状态说明

    | user       | pid    | %cpu      | %mem       | vsz            | rss        | tty      | stat     | start      | time        | command        |
    | ---------- | ------ | --------- | ---------- | -------------- | ---------- | -------- | -------- | ---------- | ----------- | -------------- |
    | 进程所有者 | 进程ID | cpu占用率 | 内存占用率 | 虚拟内存使用量 | 占固定内存 | 所在终端 | 进程状态 | 被启动时间 | 使用cpu时间 | 命令名称与参数 |

:red_circle: **top** : 动态的监视进程活动与系统负载等信息

- 第一行 : 系统时间 - 运行时间 - 登陆终端数 - 系统负载
- 第二行 : 进程总数 - 运行中的进程 - 睡眠中的进程 - 停止的进程 - 僵尸的进程
- 第三行 : 用户占用资源百分比 - 系统内核占用资源百分比 - 改变过优先级的进程系统资源 - 空闲的资源百分比
- 第四行 : 物理内存总量 - 内存使用量 - 内存控线量 - 内核缓存的内存量
- 第五行 : 虚拟内存总量 - 虚拟内存使用量 - 虚拟内存空闲量 - 已提前加载的内存量

:red_circle: **pidof** : 查询某个指定服务进程ID的PID值

```sh
pidof [参数] [服务名称]
```

:red_circle: **kill** : 用于终止某个指定PID的服务进程

:red_circle: **killall** : 用于终止某个指定名称的服务所对应的全部进程

## 第五章 Shell基础

### 5.1 基本介绍

### 5.2 基本语法

### 5.3 常用语句

# 第二篇 Linux服务与网络

## 第六章 TCP/IP基础

:red_circle: **ifconfig** : 用于获取网卡配置与网络状态等信息 

```sh
ifconfig [网络设备] [参数]
```

> - 网卡名称 : <kbd>eno ... ...</kbd>
> - inet 参数后面的 IP 地址 : <kbd>inet ... ...</kbd>
> - ether 参数后面的网卡物理地址（又称为 MAC 地址）: <kbd>ether ... ...</kbd>
> - RX 的接收数据包的个数及累计流量  : <kbd>RX Packets... ...</kbd>
> - TX 的发送数据包的个数及累计流量 : <kbd>TX Packets... ...</kbd>

:red_circle: **wget** : 在终端中下载网络问卷

```sh
wget [参数] 下载地址
```

> - 参数说明
>
> | 参数 | 作用               |
> | ---- | ------------------ |
> | -b   | 后台下载模式       |
> | -P   | 下载到指定目录     |
> | -t   | 最大尝试次数       |
> | -c   | 断点续传           |
> | -p   | 下载页面内所有资源 |
> | -r   | 递归下载           |



## 第七章 Linux企业服务

## 第八章 Linux安全原理

## 第九章 网络防火墙策略

## 第十章 Shell脚本进阶

# 第三阶段 高级进阶

## 第十一章 http服务代理缓存加速

## 第十二章 企业级负载集群

## 第十三章 企业级高可用集群

## 第十四章 运维监控与自动化学习

# 第四阶段 Linux方向

- 大数据
- 云计算
- 运维开发
- 自动化运维
- 运维架构师